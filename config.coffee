#
# Using ["The Twelve-Factor App"](http://12factor.net/) as a reference all
# environment configuration will live in environment variables. This file
# simply lays out all of those environment variables with sensible defaults
# for development.
#

module.exports =
  NODE_ENV: "development"
  PORT: 4000
  # API_URL: "http://api.are.na/v2"
  # API_URL: "http://arenaprototyperefactorb843.ninefold-apps.com/v3"
  API_URL: "http://localhost:3000/v2"
  PUSHER_KEY: '19beda1f7e2ca403abab'
  S3_KEY: null
  S3_SECRET: null
  SESSION_SECRET: 'change-me'
  SESSION_COOKIE_MAX_AGE: 31536000000
  SESSION_COOKIE_KEY: 'arena.session'
  COOKIE_DOMAIN: null
  ASSET_PATH: '/assets/'
  IMAGE_PATH: '/images/'

# Override any values with env variables if they exist
for key, val of module.exports
  val = (process.env[key] or val)
  module.exports[key] = try JSON.parse(val) catch then val