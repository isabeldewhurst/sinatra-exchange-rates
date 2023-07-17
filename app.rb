require "sinatra"
require "sinatra/reloader"
require "json"
require "http"

currency_list_url = "https://api.exchangerate.host/symbols"
currency_list = HTTP.get(currency_list_url)
p_currency_list = JSON.parse(currency_list).fetch("symbols")


get("/") do
  "
  <h1>Currency pairs</h1>"
  @currency_list_url = "https://api.exchangerate.host/symbols"
  @currency_list = HTTP.get(@currency_list_url)
  @p_currency_list = JSON.parse(@currency_list).fetch("symbols")
  
  erb(:currencies)

end

get("/:currency_1") do

  @currency_1 = params.fetch("currency_1")
  @currency_list_url = "https://api.exchangerate.host/symbols"
  @currency_list = HTTP.get(@currency_list_url)
  @p_currency_list = JSON.parse(@currency_list).fetch("symbols")

  erb(:first_pair)

end

get("/:currency_1/:currency_2") do

  @currency_1 = params.fetch("currency_1")
  @currency_2 = params.fetch("currency_2")

  @exchange_url = "https://api.exchangerate.host/convert?from=" + @currency_1 + "&to=" + @currency_2
  @rate = HTTP.get(@exchange_url)
  @p_rate = JSON.parse(@rate).fetch("info").fetch("rate").to_s

  

  erb(:second_pair)

end
