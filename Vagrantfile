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

# applications
# --------------------------------------------------------------------------
setupConfig['applications'] = []
if not setupConfig['application'].nil?
    setupConfig['applications'].push(setupConfig['application'])
end
setupConfig['subhosts'].each do |subhost|
    if not subhost['application'].nil?
        setupConfig['applications'].push(subhost['application'])
    end
end

Vagrant.configure(2) do |config|

    # Vagrant box
    # --------------------------------------------------------------------------
    config.vm.box = 'boxcutter/ubuntu1404'
    config.vm.box_version = setupConfig['box_version']
    config.vm.guest = 'ubuntu'

    # General settings
    # --------------------------------------------------------------------------
    config.vm.hostname = setupConfig['hostname']

    # Network
    # --------------------------------------------------------------------------
    if setupConfig['network']['ip'] == 'dhcp'
        config.vm.network 'private_network', type: 'dhcp'
    else
        config.vm.network 'private_network', ip: setupConfig['network']['ip']
    end

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

    if not setupConfig['subhosts'].empty?
        aliases = []
        setupConfig['subhosts'].each do |subhost|
            aliases.push(subhost['subhostname'] + '.' + setupConfig['hostname'])
        end
        config.hostmanager.aliases = aliases.join(' ')
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
        if hostos == 'bsd' || hostos == 'darwin'
            cpus = `sysctl -n hw.ncpu`.to_i
        elsif hostos == 'linux'
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
    config.vm.provision 'shell' do |sh|
        sh.path = 'ansible/ansible-on-guest.sh'
        sh.args = ['ansible/playbook.yml', setupConfig.to_json.split(' ').join('\u0020')]
    end

    if setupConfig['subhosts'].empty?
        if setupConfig['application']
            config.vm.provision 'shell', run: "always" do |sh|
                sh.path = "bindmount/" + setupConfig['application'] + ".sh"
                sh.args = [
                    setupConfig['application'],
                    '/tmp/' + setupConfig['application'],
                    '/vagrant',
                ]
            end
        end
    else
        setupConfig['subhosts'].each do |subhost|
            if subhost['application']
                config.vm.provision 'shell', run: "always" do |sh|
                    sh.path = "bindmount/" + subhost['application'] + ".sh"
                    sh.args = [
                        subhost['application'],
                        '/tmp/' + subhost['subhostname'] + '/' + subhost['application'],
                        '/vagrant/' + subhost['subhostname'],
                    ]
                end
            end
        end
    end
end
