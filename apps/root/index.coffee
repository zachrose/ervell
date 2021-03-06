#
# Handles all root requests
#
# TODO: If logged in, show feed, if not show landing
#
#

express = require "express"
routes = require "./routes"
auth = require '../../lib/middleware/auth'

app = module.exports = express()
app.set "views", __dirname + "/templates"
app.set "view engine", "jade"
app.get "/", auth, routes.index
app.get "/block/:block_id", auth, routes.index
app.get "/explore", auth, routes.explore
app.get "/explore/block/:block_id", auth, routes.index