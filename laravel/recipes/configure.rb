node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php' && deploy[:application_type] != 'php-nginx'
    Chef::Log.debug("Skipping composer::configure application #{application} as it is not an PHP app")
    next
  end

Chef::Log.info 'Fetching Libraries for app.'
bash "configure_app" do
  user "deploy"
  cwd "#{deploy[:deploy_to]}/laravel"
  code <<-EOH
    composer install
    npm install
    gulp
    bower update
    php artisan migrate
  EOH
end
