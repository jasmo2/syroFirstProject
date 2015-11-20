require 'syro'
require 'json'
require './library/query_maker'
class MyJson <  Syro::Deck
  def default_headers
    { 'Content-Type' => 'application/json' }
  end
  def my_response(obj)
    obj[:fecha_i] = SQL_date_format(obj[:fecha_i]);
    obj[:fecha_f] = SQL_date_format(obj[:fecha_f]);
    q = QueryMaker.new
    passengers,tripRounds = q.get_passengers(obj[:bus_id],obj[:fecha_i],obj[:fecha_f])
    res.write JSON.generate({'passengerQuantity' => dataAnalitic(passengers),'tripRounds' => dataAnalitic(tripRounds)})
  end

  private
  def SQL_date_format(date)
    "%{Y}-%{m}-%{d} %{H}:%{M}:%{S}" % {
        Y:doubleNumber(Time.at(date).year),
        m:doubleNumber(Time.at(date).month),
        d:doubleNumber(Time.at(date).day),
        H:doubleNumber(Time.at(date).hour),
        M:doubleNumber(Time.at(date).min),
        S:doubleNumber(Time.at(date).sec)
    }
  end
  def doubleNumber(number)
    if (number < 10)
      return "0#{number.to_s}"
    end
    number.to_s
  end
  def dataAnalitic (passangers)
    if passangers == 0
      return "Aun no hay datos analizados"
    end
    passangers
  end
end