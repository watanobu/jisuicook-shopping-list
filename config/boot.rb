ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

raw_database_url = ENV["DATABASE_URL"]
if raw_database_url && !raw_database_url.empty?
  # Normalize Railway's non-standard scheme before Rails parses DB config.
  ENV["DATABASE_URL"] = raw_database_url
    .sub(/\Arailwaymysql:/, "mysql2:")
    .sub(/\Amysql:/, "mysql2:")
end

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
