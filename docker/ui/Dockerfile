FROM ruby:2.2
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV POST_SERVICE_HOST post_host
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment_host
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
