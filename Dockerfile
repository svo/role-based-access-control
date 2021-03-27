FROM ruby:3.0.0
WORKDIR /opt/role-based-access-control
COPY . .
RUN bin/setup-production
CMD ["bin/run"]
