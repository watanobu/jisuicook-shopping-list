ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

raw_database_url = ENV["DATABASE_URL"]
if raw_database_url && !raw_database_url.empty?
  # Normalize Railway's non-standard scheme and map DATABASE_URL into MYSQL_*.
  normalized_url = raw_database_url
    .sub(/\Arailwaymysql:/, "mysql2:")
    .sub(/\Amysql:/, "mysql2:")

  begin
    require "uri"
    uri = URI.parse(normalized_url)
    if uri.scheme == "mysql2"
      ENV["MYSQL_HOST"] ||= uri.host if uri.host
      ENV["MYSQL_PORT"] ||= uri.port.to_s if uri.port
      ENV["MYSQL_USER"] ||= URI.decode_www_form_component(uri.user) if uri.user
      ENV["MYSQL_PASSWORD"] ||= URI.decode_www_form_component(uri.password) if uri.password

      if uri.path && uri.path.length > 1
        db_name = uri.path.sub(%r{\A/}, "")
        ENV["MYSQL_DATABASE_PRODUCTION"] ||= db_name
        ENV["MYSQL_DATABASE"] ||= db_name
      end
    end
  rescue URI::InvalidURIError
    # If parsing fails, keep the original env vars as-is.
  end

  ENV["DATABASE_URL"] = normalized_url
end

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
