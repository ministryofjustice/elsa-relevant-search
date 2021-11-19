# Search information about legal problems

[![CI and CD](https://github.com/ministryofjustice/elsa-relevant-search/actions/workflows/test-build-deploy.yml/badge.svg)](https://github.com/ministryofjustice/elsa-relevant-search/actions/workflows/test-build-deploy.yml)

This is a Rails application to enable citizens to find, with the help of a Google [custom search engine](https://programmablesearchengine.google.com/intl/en_uk/about/) 
relevant information and websites about legal problems.

## Getting Started

Clone the repository, and follow these steps:

* Copy `.env.example` to `.env` and modify with suitable values
* `gem install bundler` # if you don't have it already
* `bundle install`
* Pull the GOV.UK Frontend assets (instructions below)
* `bin/rails db:setup`
* `bin/rails db:migrate`
* `bin/rails server`

##### GOV.UK Frontend (styles, javascript and other assets)

* `brew install yarn` # if you don't have it already
* `yarn` # this will install the dependencies

### Running the tests:

* Copy `.env.test.example` to `.env.test` and modify with suitable values.
* `RAILS_ENV=test bin/rails db:setup`
* `RAILS_ENV=test bin/rails db:migrate`

You can then run all the code linters and tests with:

* `rake`

Or you can run specific tests as follows (refer to *lib/tasks/all_tests.rake* for the complete list):

* `rake spec`
* `rake brakeman`
* `rake rubocop`

## Docker

The application can be run inside a docker container. This will take care of the ruby environment, postgres database 
and any other dependency for you, without having to configure anything in your machine.

* `docker-compose up`

The application will be run in "production" mode, so will be as accurate as possible to the real production environment.

**NOTE:** never use `docker-compose` for a real production environment. This is only provided to test a local container.

## K8s cluster staging environment

There is a staging environment running on [this url][k8s-staging]

The staging env uses http basic auth to restrict access. The username and password is available in confluence.

This environment should be used for any test or demo purposes, user research, etc.
Do not use production for tests as this will have an impact on analytics.

There is a [deploy repo][deploy-repo] for this staging environment (as well as for production).
It contains the k8s configuration files and also the required ENV variables.

## Continuous integration and deployment

GitHub actions are used for CI and CD and you can find the configuration in `.github/workflows/test-build-deploy.yml`

After a successful merge to `main`, a docker image will be created and pushed to an ECR repository.
It will then trigger an automatic deploy to [staging][k8s-staging].

For more details, refer to the [deploy repo][deploy-repo].

[deploy-repo]: https://github.com/ministryofjustice/elsa-relevant-search-deploy
[k8s-staging]: https://elsa-relevant-search-staging.apps.live.cloud-platform.service.justice.gov.uk
