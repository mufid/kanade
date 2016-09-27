module JsonReader
  def json_of(fixture_name)
    path = File.join(File.dirname(__FILE__), '..', 'fixtures', "#{fixture_name.to_s}.json")
    json = File.read path
  end
end
