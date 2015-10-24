require "syro"

app = Syro.new {
  get{
    res.write "root"
  }
  on("foo") {
    on("bar") {
      get {
        res.write "GET /foo/bar/"
      }
      on("baz") {
        get {
          res.write "GET /foo/bar/baz"
        }
      }
    }
  }
  on("posts") {
    on(:post_id) {
      get {
        res.write "GET /posts/#{inbox[:post_id]}"
      }
      on("comments"){
        res.write "GET /posts/#{inbox[:post_id]}/comments"
      }
    }
  }
  on(env["HTTP_REFERER"] != "") {
    get {
      res.write "HTTP_REFERER => #{env["HTTP_REFERER"]}"
    }
  }

}