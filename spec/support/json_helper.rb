module JsonHelper
  def parsed_response
    @parsed_response ||= JSON.parse response.body
  end
end
