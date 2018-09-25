Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

# Optimization credits to https://stefanwrobel.com/how-to-make-vagrant-performance-not-suck
# Required for NFS to work, pick any local IP
# config.vm.network :private_network, ip: '192.168.99.99'

# Use NFS for shared folders for better performance
# config.vm.synced_folder '.', '/vagrant', nfs: true

config.vm.provider "virtualbox" do |v|
  host = RbConfig::CONFIG['host_os']

  # Give VM 1/4 system memory & access to half of the cpu cores on the host
  if host =~ /darwin/
    cpus = `sysctl -n hw.ncpu`.to_i / 2
    # sysctl returns Bytes and we need to convert to MB
    mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
  elsif host =~ /linux/
    cpus = `nproc`.to_i / 2
    # meminfo shows KB and we need to convert to MB
    mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
  else # sorry Windows folks, I can't help you
    cpus = 2
    mem = 1024
  end

  v.customize ["modifyvm", :id, "--memory", mem]
  v.customize ["modifyvm", :id, "--cpus", cpus]
  v.customize ["modifyvm", :id, "--vram", 16]
end

config.vm.provider "virtualbox" do |v|
  v.gui = true
end

config.vm.provision "shell",
   inline: "sudo apt-get update"

config.vm.provision "shell",
   inline: "sudo apt-get install -y node python curl wget"

end
