FROM ruby:2.7.0

RUN apt-get update -y
RUN apt-get install -y nodejs postgresql-client
RUN curl -L https://npmjs.org/install.sh | sh
RUN npm install -g yarn

RUN mkdir -p /app

COPY . /app
WORKDIR /app
RUN bundle install
RUN rake db:migrate
RUN rake assets:precompile

EXPOSE 3000

ENTRYPOINT ["rails", "server"]
