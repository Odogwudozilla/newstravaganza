desc "This task is called by the Heroku scheduler add-on"
task :update_keywords => :environment do
  Rails.application.load_seed.seed_keywords
end

