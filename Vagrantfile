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
userDefaultConfigPath = Dir.home + '/.vagrant-default-user.yml'
projectConfigPath = setupPath + '/../vagrant.yml'
userProjectConfigPath = setupPath + '/../vagrant-user.yml'

setupConfig = YAML.load_file(defaultConfigPath)

if File.file?(userDefaultConfigPath)
    userDefaultConfig = YAML.load_file(userDefaultConfigPath)
    setupConfig = setupConfig.deep_merge(userDefaultConfig)
end

if File.file?(projectConfigPath)
    projectConfig = YAML.load_file(projectConfigPath)
    setupConfig = setupConfig.deep_merge(projectConfig)
end

if File.file?(userProjectConfigPath)
    userConfig = YAML.load_file(userProjectConfigPath)
    setupConfig = setupConfig.deep_merge(userConfig)
end

# hostos
# --------------------------------------------------------------------------
if Vagrant::Util::Platform.bsd?
    hostos = 'bsd'
elsif Vagrant::Util::Platform.darwin?
    hostos = 'darwin'
elsif Vagrant::Util::Platform.linux?
    hostos = 'linux'
elsif Vagrant::Util::Platform.windows?
    hostos = 'windows'
else
    hostos = 'unknown'
end

Vagrant.configure(2) do |config|

    # Vagrant box
    # --------------------------------------------------------------------------
    config.vm.box = setupConfig['box']
    config.vm.guest = 'ubuntu'

    # General settings
    # --------------------------------------------------------------------------
    config.vm.hostname = setupConfig['hostname']

    # Network
    # --------------------------------------------------------------------------
    config.vm.network 'private_network', ip: setupConfig['network']['ip']

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
    config.hostmanager.manage_guest = true

    if setupConfig['role']['nginx']
        aliases = []
        certificates = [setupConfig['hostname']];

        setupConfig['nginx']['server'].each do |hostconfig|
            hostconfig['server_name'].split(' ').each do |serverNamePart|
                if serverNamePart != '' and serverNamePart != setupConfig['hostname']
                    aliases.push(serverNamePart)
                    certificates.push(serverNamePart)
                end
            end
        end

        config.hostmanager.aliases = aliases.join(' ')

        setupConfig['nginx']['certificates'] = certificates
    end

    # Synced folder
    # --------------------------------------------------------------------------
    config.vm.synced_folder '.', '/vagrant', disabled: true

    if hostos == 'windows'
        smboptions = {
            :create => true,
            :smb => true
        }

        config.vm.synced_folder './..', '/vagrant', smboptions
    else
        nfsoptions = {
            :create => true,
            :nfs => true,
            :mount_options => setupConfig['nfsoptions']['mount_options'],
            :nfs_udp => setupConfig['nfsoptions']['udp'],
            :bsd__nfs_options => setupConfig['nfsoptions']['bsd'],
            :linux__nfs_options => setupConfig['nfsoptions']['linux']
        }

        config.vm.synced_folder './..', '/vagrant', nfsoptions
    end

    # Resources of our box
    # --------------------------------------------------------------------------

    # define cpu count
    if setupConfig['cpus']
        cpus = setupConfig['cpus']
    else
        if hostos == 'bsd' || hostos == 'darwin'
            cpus = `sysctl -n hw.ncpu`.to_i
        elsif hostos == 'linux'
            cpus = `nproc`.to_i
        elsif hostos == 'windows'
            cpus = `echo %NUMBER_OF_PROCESSORS%`.to_i
        else
            cpus = 2
        end
    end

    # for virtualbox
    config.vm.provider 'virtualbox' do |v|
        v.name = setupConfig['hostname']
        v.memory = setupConfig['memory']
        v.cpus = cpus

        if setupConfig['virtualbox'].key?(hostos)
            setupConfig['virtualbox'][hostos].each do |key, value|
                v.customize ['modifyvm', :id, '--' + key, value]
            end
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
    config.vm.provision 'ansible_local' do |ansible|
        ansible.playbook = 'vagrant-php/ansible/playbook.yml'
        ansible.install_mode = 'pip'
        ansible.pip_install_cmd = "curl https://bootstrap.pypa.io/get-pip.py | sudo python"
        ansible.version = '2.8.4'
        ansible.extra_vars = setupConfig
        ansible.compatibility_mode = '2.0'
    end
end
