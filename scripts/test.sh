apt-get update -y
apt-get install -y nodejs
curl -L https://npmjs.org/install.sh | sh
npm install -g yarn
bundle install
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rake assets:precompile
bundle exec rspec
