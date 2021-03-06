http = require 'http'
fs   = require 'fs'
url  = require 'url'

app_handler = (req, res) ->
  _url = url.parse(decodeURI(req.url), true);
  path = if _url.pathname == '/' then '/index.html' else _url.pathname
  console.log "#{req.method} - #{path}"
  fs.readFile __dirname+path, (err, data) ->
    if err
      res.writeHead 500
      return res.end 'error load file'
    res.writeHead 200
    res.end data

app = http.createServer(app_handler)
io = require('socket.io').listen(app)

linda = require('linda').Server.listen(io: io, server: app)

process.env.PORT ||= 3000
app.listen process.env.PORT
console.log "server start - port:#{process.env.PORT}"
