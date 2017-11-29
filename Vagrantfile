# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "box-cutter/ubuntu1604-desktop"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network "private_network", ip: "192.168.35.10"
  #config.vm.network "private_network", ip: "192.170.35.10"
  config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"
  #config.vm.network "public_network", ip: "192.170.36.17"

  #
  config.vm.provision "shell", inline: "sudo apt-get install nfs-common"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  # nfs provides better synced folder performance on Linux and OSX.
  # nfs is ignored on Windows.
  config.vm.synced_folder "..", "/vagrant", type: "nfs"
  #config.vm.synced_folder "..", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:

  config.vm.provider "vmware_fusion" do |config|
    ## Display the VirtualBox GUI when booting the machine
    config.gui = true

    ## Set the amount of meory in megabytes.
    config.vmx["memsize"] = "8192"
    ##config.vmx["memsize"] = "4096"

    ## Set the number of processors.
    config.vmx["numvcpus"] = "4"

    # This error occurs because the Ubuntu tries to raise all your network interfaces, but your cable isn't connected, then he waits until his timeout.
    # Link: https://github.com/mitchellh/vagrant/issues/8056
    #vb.customize ["modifyvm", :id, "--cableconnected1", "on"]

    #config.vmx["ethernet0.pcislotnumber"] = "160"
    #config.vmx["ethernet1.pcislotnumber"] = "32"

    config.vmx["ethernet0.connectionType"] = "hostonly"
    config.vmx["ethernet1.connectionType"] = "nat"

    config.vmx["ethernet0.startConnected"] = "TRUE"
    config.vmx["ethernet1.startConnected"] = "TRUE"

    #config.vmx["ethernet0.linkStatePropagation.enable"] = "TRUE"
    #config.vmx["ethernet1.linkStatePropagation.enable"] = "TRUE"

    #config.vmx["ethernet0.wakeOnPcktRcv"] = "FALSE"
    #config.vmx["ethernet1.wakeOnPcktRcv"] = "FALSE"

    #config.vmx["ethernet0.vnet"] = "vmnet3"
    #config.vmx["ethernet1.vnet"] = "vmnet4"

    #config.vmx["ethernet0.bsdName"] = "en7"
    #config.vmx["ethernet1.bsdName"] = "en8"

    #config.vmx["ethernet0.displayName"] = "abc"
    #config.vmx["ethernet1.displayName"] = "xyz"

  end

  config.vm.provider "virtualbox" do |vb|
    ## Display the VirtualBox GUI when booting the machine
    vb.gui = true

    ## Set name.
    #vb.name = ""

    ##
    vb.customize ["modifyvm", :id, "--cpus", "4"]

    ## Customize the amount of memory on the VM:
    vb.memory = "4096"

    ## Set video memory.
    # (http://stackoverflow.com/questions/24231620/how-to-set-vagrant-virtualbox-video-memory)
    # (https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm)
    vb.customize ["modifyvm", :id, "--vram", "128"]

    ## Activate 3D acceleration.
    vb.customize ["modifyvm", :id, "--accelerate3d", "off"]

    ## Deactivate 2D acceleration.
    vb.customize ["modifyvm", :id, "--accelerate2dvideo", "on"]

    ## Activate/Deactivate audio.
    ## http://stackoverflow.com/questions/26811089/vagrant-how-to-have-host-platform-specific-provisioning-steps

    #if Vagrant::Util::Platform.windows?
      #vb.customize ["modifyvm", :id, "--audio", "dsound"]
    #elseif Vagrant::Util::Platform.darwin?
      #vb.customize ["modifyvm", :id, "--audio", "coreaudio"]
    #else
      #vb.customize ["modifyvm", :id, "--audio", "none"]
    #end

    module OS
      def OS.windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      end

      def OS.mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
      end

      def OS.unix?
        !OS.windows?
      end

      def OS.linux?
        OS.unix? and not OS.mac?
      end
    end

    if OS.windows?
      vb.customize ["modifyvm", :id, "--audio", "dsound"]
    elsif OS.mac?
      vb.customize ["modifyvm", :id, "--audio", "coreaudio"]
    else
      vb.customize ["modifyvm", :id, "--audio", "none"]
    end

    ##
    vb.customize ["modifyvm", :id, "--audiocontroller", "hda"]

  end

  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  config.vm.provision :shell, path: "install.sh"

  config.vm.provider "vmware_fusion" do |vmw|
    config.vm.provision "shell", inline: <<-SHELL
     apt-get install -y open-vm-tools open-vm-tools-desktop
   SHELL
  end
end
