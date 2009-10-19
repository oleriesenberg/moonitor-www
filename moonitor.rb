require 'rubygems'
require 'sinatra'
require 'erb'
require 'grit'

include Grit

REPO = development? ? 
          Repo.new("/home/hoodow/scm/overlay/.git") :
            Repo.new("/home/git/repositories/overlay.git")

class Package
  attr :atom, true
  attr :versions, true
  attr :description, true
  attr :iuse, true

  def initialize(category, package)
    versions = []
    package.contents.each do |atom|
      versions << atom.name.sub("#{package.name}-", '').sub('.ebuild', '') if atom.name =~ /.ebuild$/
    end

    blob = REPO.tree / "#{category.name}/#{package.name}/#{package.name}-#{versions.last}.ebuild"
    description = blob.data.scan(/^DESCRIPTION="(.*)"$/) if blob
    iuse = blob.data.scan(/^IUSE="(.*)"$/) if blob

    self.atom = "#{category.name}/#{package.name}"
    self.versions = versions if versions
    self.description = (blob.nil? or description.empty?) ? nil : description[0][0]
    self.iuse = (blob.nil? or iuse.empty?) ? nil : iuse[0][0].split
  end

  def versions_string
    self.versions.join(' | ')
  end

  def iuse_string
    self.iuse.sort.join(' ')
  end
end

get '/' do
  erb :index
end

get '/overlay/' do
  @packages = []
  REPO.tree.contents.each do |category|
    unless category.name =~ /(profiles|eclass|metadata)/
      category.contents.each do |package|
        @packages << Package.new(category, package)
      end
    end
  end
  erb :overlay
end
