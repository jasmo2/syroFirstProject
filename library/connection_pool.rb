require 'tiny_tds'
class ConnectionPool
  # bus_id,fecha_i,fecha_f
  @client = nil
  def initialize
    connect
    @client
  end
  def execute query=""
    @client.execute(query).each()
  end
  def close
    @client.close
  end
  private
  def connect
    @client = TinyTds::Client.new username: ENV['COONATRA_USERNAME'],
                                  password: ENV['COONATRA_PASSWORD'],
                                  port: ENV['COONATRA_PORT'],
                                  host: ENV['COONATRA_IP'],
                                  database: ENV['COONATRA_DB']
  end
end