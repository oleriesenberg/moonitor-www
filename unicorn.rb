worker_processes 3
timeout 30
listen '/tmp/unicorn-moonitor.sock', :backlog => 2048

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

