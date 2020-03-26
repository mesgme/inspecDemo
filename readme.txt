inspec-http.rb

On a remote machine (I used my local) run install based on the instructions at https://www.inspec.io/downloads/ then run inspec exec inspec-http.rb.

This tests the functionality of the website by ensuring that the URL and content of the key pages remains consistent.  
This pins the functionality and allows the deployment process to be changed without any impact.

inspec-apache.rb
On the apache server run inspec exec inspec-apache.rb
This tests the initial setup of apache.  Having ensured that apache2 was installed correctly I pulled across the baseline tests from https://github.com/dev-sec/apache-baseline to ensure that apache was configured securely.  I did this adding one control at a time and then altering the installation process to make the tests pass.  I am a big believer in TDD (and Kent Beck's Test && Commit || Revert https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864) and see no reason why this should not be applied to infrastructure as code as it forces incremental testable change.  Further work would be to continue pulling across controls and rerunning the tests.


hosts
Install ansible on an admin server 
Replace the existing /etc/ansible/hosts file with the contents - this can be added to with connection details for additonal servers as required

installapache.yml
On the remote server run ansible-playbook installapache.yml - this should connect to the apache server and run the correct installation process.  rerun inspec-apache.rb to check this.