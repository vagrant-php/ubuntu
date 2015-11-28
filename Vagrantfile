require 'json'
require 'yaml'

# hash deep merge method
# --------------------------------------------------------------------------
class ::Hash
    def deep_merge(second)
        merger = proc do |key, v1, v2|
          if Hash === v1 && Hash === v2
            v1.merge(v2, &merger)
          elsif Array === v1 && Array === v2
            v1 | v2
          elsif [:undefined, nil, :nil].include?(v2)
            v1
          else
            v2
          end
        end
        self.merge(second.to_h, &merger)
    end
end

# config
# --------------------------------------------------------------------------
setupPath = File.dirname(File.expand_path(__FILE__))

defaultConfigPath = setupPath + '/vagrant-default.yml'
projectConfigPath = setupPath + '/../vagrant.yml'
userConfigPath = setupPath + '/../vagrant-user.yml'

setupConfig = YAML.load_file(defaultConfigPath)

if File.file?(projectConfigPath)
    projectConfig = YAML.load_file(projectConfigPath)
    setupConfig = setupConfig.deep_merge(projectConfig)
end

if File.file?(userConfigPath)
    userConfig = YAML.load_file(userConfigPath)
    setupConfig = setupConfig.deep_merge(userConfig)
end

Vagrant.configure(2) do |config|

    # Vagrant box
    # --------------------------------------------------------------------------
    config.vm.box = 'boxcutter/ubuntu1404'

    # General settings
    # --------------------------------------------------------------------------
    config.vm.hostname = setupConfig['hostname']

    # Network
    # --------------------------------------------------------------------------
    config.vm.network 'private_network', type: 'dhcp'

    setupConfig['network']['forwarded_ports'].each do |id, options|
        if options['host'] == 'ephemeral'
            options['host'] = Random.rand(49152..65535)
        end
        config.vm.network :forwarded_port, id: id, guest: options['guest'], host: options['host'], auto_correct: true
    end

    # SSH stuff
    # --------------------------------------------------------------------------
    config.ssh.forward_agent = true

    # Hostmanager
    # --------------------------------------------------------------------------
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
        if hostname = (vm.ssh_info && vm.ssh_info[:host])
            `vagrant ssh -c 'hostname -I'`.split()[1]
        end
    end

    # Synced folder
    # --------------------------------------------------------------------------
    config.vm.synced_folder '.', '/vagrant', disabled: true

    if setupConfig['sharetype'] == 'native'
        config.vm.synced_folder './..', '/vagrant'
    elsif setupConfig['sharetype'] == 'nfs' or setupConfig['sharetype'] == 'nfs-bindfs'
        config.nfs.map_uid = Process.uid
        config.nfs.map_gid = Process.gid
        nfsoptions = {
            :create => true,
            :nfs => true,
            :nfs_udp => setupConfig['nfsoptions']['udp'],
            :bsd__nfs_options => setupConfig['nfsoptions']['bsd'],
            :linux__nfs_options => setupConfig['nfsoptions']['linux']
        }
        if setupConfig['sharetype'] == 'nfs-bindfs'
            config.vm.synced_folder './..', '/vagrant-nfs', nfsoptions
            config.bindfs.bind_folder '/vagrant-nfs', '/vagrant'
        else
            config.vm.synced_folder './..', '/vagrant', nfsoptions
        end
    else
        print "no valid sharetype, please take a look into README.md!\n"
    end



    # Resources of our box
    # --------------------------------------------------------------------------

    # define cpu count
    if setupConfig['cpus']
        cpus = setupConfig['cpus']
    else
        if Vagrant::Util::Platform.darwin? || Vagrant::Util::Platform.bsd?
            cpus = `sysctl -n hw.ncpu`.to_i
        elsif Vagrant::Util::Platform.linux?
            cpus = `nproc`.to_i
        else
            cpus = 2
        end
    end

    # for virtualbox
    config.vm.provider 'virtualbox' do |v|
        v.name = setupConfig['hostname']
        v.memory = setupConfig['memory']
        v.cpus = cpus
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]

        if not Vagrant::Util::Platform.windows?
            # use virtio networkcards on unix hosts
            v.customize ['modifyvm', :id, '--nictype1', 'virtio']
            v.customize ['modifyvm', :id, '--nictype2', 'virtio']
        end
    end

    # for vmware fusion (osx)
    config.vm.provider "vmware_fusion" do |v|
        v.vmx['displayname'] = setupConfig['hostname']
        v.vmx['memsize'] = setupConfig['memory']
        v.vmx['numvcpus'] = cpus
        v.vmx['vhv.enable'] = 'TRUE'
    end

    # for vmware workstation (windows, linux)
    config.vm.provider "vmware_workstation" do |v|
        v.vmx['displayname'] = setupConfig['hostname']
        v.vmx['memsize'] = setupConfig['memory']
        v.vmx['numvcpus'] = cpus
        v.vmx['vhv.enable'] = 'TRUE'
    end

    # Provisioning
    # --------------------------------------------------------------------------
    config.vm.provision 'shell' do |sh|
        sh.path = 'ansible/ansible-on-guest.sh'
        sh.args = ['ansible/playbook.yml', setupConfig.to_json.split(' ').join('\u0020')]
    end
end
