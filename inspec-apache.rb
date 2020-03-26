control 'apache-01' do
        impact 1.0
        title 'Apache should be running'
        desc 'Apache should be running'
        describe service(apache.service) do
                it { should be_installed }
                it { should be_running }
        end
end
control 'apache-02' do
  impact 1.0
  title 'Apache should be enabled'
  desc 'Configure apache service to be automatically started at boot time'
  describe service(apache.service) do
    it { should be_enabled }
  end
end
control 'apache-03' do
        impact 1.0
        title 'Port 80 should be listening'
        desc 'Port 80- should be listening'
        describe port(80) do
                it { should be_listening }
        end
end
control 'apache-04' do
        impact 1.0
        title 'Check virtuals setup'
        desc 'Check default server set to leddis and port is correct'
        describe command('sudo apachectl -S') do
                its('stdout') { should cmp /default server www.leodis.ac.uk/ }
                its('stdout') { should cmp /port 80 namevhost www.leodis.ac.uk/ }
        end
end

control 'apache-05' do
  title 'Apache should start max. 1 root-task'
  desc 'The Apache service in its own non-privileged account. If the web server process runs with administrative privileges, an attack who obtains control over the apache process may control the entire system.'
  total_tasks = command("ps aux | grep #{apache.service} | grep -v grep | grep root | wc -l | tr -d [:space:]").stdout.to_i
  describe total_tasks do
    it { should eq 1 }
  end
end

control 'apache-06' do
  impact 1.0
  title 'Check Apache config folder owner, group and permissions.'
  desc 'The Apache config folder should owned and grouped by root, be writable, readable and executable by owner. It should be readable, executable by group and not readable, not writeable by others.'
  describe file(apache.conf_dir) do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by('owner') }
    it { should be_writable.by('owner') }
    it { should be_executable.by('owner') }
    it { should be_readable.by('group') }
    it { should_not be_writable.by('group') }
    it { should be_executable.by('group') }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should be_executable.by('others') }
  end
end

control 'apache-07' do
  impact 1.0
  title 'Check Apache config file owner, group and permissions.'
  desc 'The Apache config file should owned and grouped by root, only be writable and readable by owner and not write- and readable by others.'
  describe file(apache.conf_path) do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by('owner') }
    it { should be_writable.by('owner') }
    it { should_not be_executable.by('owner') }
    it { should be_readable.by('group') }
    it { should_not be_writable.by('group') }
    it { should_not be_executable.by('group') }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should_not be_executable.by('others') }
  end
end
