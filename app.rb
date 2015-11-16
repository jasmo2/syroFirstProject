require "./library/my_json.rb"

App = Syro.new(MyJson) {
  get{
    res.write "root"
  }
  on("bus_id") {
    on(:bus_id) {
      on("fecha_i"){
        on(:fecha_i){
          on("fecha_f"){
            on(:fecha_f){
              get {
                my_response(
                    bus_id: inbox[:bus_id],
                    fecha_i: Time.at(inbox[:fecha_i].to_i),
                    fecha_f: Time.at(inbox[:fecha_f].to_i),
                )
              }
            }
          }
        }
      }
    }
  }
}