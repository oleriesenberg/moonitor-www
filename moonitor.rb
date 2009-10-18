require 'rubygems'
require 'sinatra'
require 'erb'
require 'grit'

include Grit

class Package
  attr :atom, true
  attr :versions, true
  attr :description, true

  def initialize(atom, versions=nil, description=nil)
    self.atom = atom
    self.versions = versions if versions
    self.description = description if description
  end

  def versions_string
    self.versions.join(' | ')
  end
end

get '/' do
  erb :index
end

get '/overlay/' do
  @repo = development? ? 
            Repo.new("/home/hoodow/scm/overlay/.git") :
              Repo.new("/home/git/repositories/overlay.git")

  @packages = []
  @repo.tree.contents.each do |category|
    unless category.name =~ /(profiles|eclass|metadata)/
      category.contents.each do |package|
        versions = []
        package.contents.each do |atom|
          version = atom.name.scan(/-(?:\d.+)/)
          versions << version.first.sub('-', '').sub('.ebuild', '') unless version.empty?
        end
        @packages << Package.new("#{category.name}/#{package.name}", versions)
      end
    end
  end
  erb :overlay
end
