control "http1" do
  impact 1.0
  title "http 1 Ensure website up"
  desc "ec2-34-249-39-216.eu-west-1.compute.amazonaws.com should be up"
  describe http('http://ec2-34-249-39-216.eu-west-1.compute.amazonaws.com') do
   its('status') { should cmp 200 }
   its('body') { should match /nonsense/ }
  end
end
control "http2" do
  impact 1.0
  title "http 2 Ensure courses page up"
  desc "courses page should be up"
  describe http('http://ec2-34-249-39-216.eu-west-1.compute.amazonaws.com/courses') do
   its('status') { should cmp 200 }
   its('body') { should match /select/ }
  end
end
control "http3" do
  impact 1.0
  title "http 3 Ensure VLE page up"
  desc "VLE page should be up"
  describe http('http://ec2-34-249-39-216.eu-west-1.compute.amazonaws.com/vle') do
   its('status') { should cmp 200 }
   its('body') { should match /Username/ }
  end
end

