require 'syro'
require 'json'
require '.query_maker'
class MyJson <  Syro::Deck
  def default_headers
    { 'Content-Type' => 'application/json' }
  end
  def my_response(obj)
    res.write JSON.dump({'ans' => "this is the answer for #{obj[:placa_bus]}"}.to_json)
  end
end