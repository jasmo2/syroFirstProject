require './library/connection_pool'
class QueryMaker
  @connection
  FIELDS = ["subidas", "bajadas"]
  def initialize
    @connection = ConnectionPool.new
  end
  def get_passengers placa_bus , fecha_i, fecha_f
    #@connection.execute("SELECT #{FIELDS.join(",")} FROM CHEQUEO_VIRTUAL WHERE #{}")
    response = @connection.execute("SELECT #{FIELDS.join(",")} FROM VEHICULO WHERE [ID_VEHICULO]=#{get_vehicle_id(placa_bus)} AND  ")
    @connection.close
    response
  end
  private
  def get_vehicle_id(placa_bus)
    placa_espacio = placa_bus
    placa_espacio.insert(3, " ")
    @connection.execute("SELECT [ID_VEHICULO] FROM VEHICULO WHERE [PLACA]='#{placa_bus}' OR [PLACA]='#{placa_espacio} ")
  end
end