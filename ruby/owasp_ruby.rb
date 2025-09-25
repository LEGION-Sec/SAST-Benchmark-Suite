require "sqlite3"
require "rexml/document"
require "sinatra"
require "erb"
require "json"

class VulnerableRuby
  def sql_injection(user_input)
    db = SQLite3::Database.new "test.db"
    query = "SELECT * FROM users WHERE username = '#{user_input}'"
    db.execute(query)
  end

  def broken_auth(username, password)
    username == "adminuser" && password == "xchzdhkrltu"
  end

  def store_sensitive_data
    File.write("passwords.txt", "admin:Passwo#d@&1957")
  end

  def parse_xml(xml_data)
    doc = REXML::Document.new(xml_data)
  end

  get "/security_misconfig" do
    response = "Security Misconfiguration Example"
    headers "X-Powered-By" => "Ruby-Sinatra"
    response
  end

  get "/access" do
    role = params["role"]
    if role == "admin"
      "Welcome Admin!"
    else
      "Access Denied!"
    end
  end

  get "/xss" do
    user_input = params["input"]
    "<html><body>#{user_input}</body></html>"
  end

  def insecure_deserialization(data)
    obj = JSON.parse(data)
  end
end
