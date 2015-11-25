module JSONhelper
  def response_in_json
    # binding.pry
    JSON.parse(response.body)
  end
end
