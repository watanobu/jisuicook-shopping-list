raw_database_url = ENV["DATABASE_URL"]
return if raw_database_url.nil? || raw_database_url.empty?

# Railway uses a non-standard scheme; normalize so ActiveRecord can parse it.
normalized_url = raw_database_url
  .sub(/\Arailwaymysql:/, "mysql2:")
  .sub(/\Amysql:/, "mysql2:")

ENV["DATABASE_URL"] = normalized_url
