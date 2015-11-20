require './library/connection_pool'
class QueryMaker
  @connection
  FIELDS = ["subidas", "bajadas"]
  def initialize
    @connection = ConnectionPool.new
  end
  def get_passengers bus_id , fecha_i, fecha_f
    #ToDo Errase line above ,just for testing
    # bus_id=371
    str = "SELECT v.[PLACA],v.[COD_VEHICULO], rt.[PASAJEROS_AUTOMATICO], rt.[PASAJEROS_ORIGINALES], rt.[FECHA_HORA_FINAL], rt.[FECHA_HORA_INICIAL] FROM RUTA_SELECCIONADA rt JOIN VEHICULO v on rt.[ID_VEHICULO]=v.[ID_VEHICULO] WHERE rt.[FECHA_HORA_INICIAL] BETWEEN '#{fecha_i}' AND '#{fecha_f}' AND v.[COD_VEHICULO]=#{bus_id} ORDER BY rt.[FECHA_HORA_INICIAL]"
    response = @connection.execute(str)
    @connection.close
    get_total_passengers(response)
  end

  private
  def get_total_passengers(records)
    total_passengers = 0
    tripRounds = 0
    records.each_with_index do|record, i|
      if i == 0
        total_passengers+=record['PASAJEROS_ORIGINALES']
        tripRounds += 1
      elsif !records[i]['FECHA_HORA_INICIAL'].eql?(records[i-1]['FECHA_HORA_INICIAL']) && !records[i]['FECHA_HORA_FINAL'].eql?(records[i-1]['FECHA_HORA_FINAL'])
        total_passengers+=record['PASAJEROS_ORIGINALES']
        tripRounds += 1
      end
    end
    return total_passengers, tripRounds
  end
  def get_vehicle_id(placa_bus)
    placa_espacio = placa_bus
    placa_espacio.insert(3, " ")
    @connection.execute("SELECT [ID_VEHICULO] FROM VEHICULO WHERE [PLACA]='#{placa_bus}' OR [PLACA]='#{placa_espacio} ")
  end
end