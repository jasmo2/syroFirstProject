require "./library/my_json.rb"

App = Syro.new(MyJson) {
  get{
    res.write "root"
  }
  on("placa_bus") {
    on(:placa_bus) {
      on("fecha_i"){
        on(:fecha_i){
          on("fecha_f"){
            on(:fecha_f){
              get {
                my_response(
                    placa_bus: inbox[:placa_bus],
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