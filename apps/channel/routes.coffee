#
# Routes file that exports route handlers for ease of testing.
#

Channel = require "../../models/channel"
ChannelBlocks = require "../../collections/channel_blocks"
User = require "../../models/user"

@channel = (req, res, next) ->
  channel = new Channel
    channel_slug: req.params.channel_slug

  blocks = new ChannelBlocks null,
    channel_slug: req.params.channel_slug

  if req.params.block_id
    res.locals.sd.CLIENT_PATH = "block/#{req.params.block_id}"

  channel.fetch
    cache: true
    success: ->
      blocks.add channel.get 'contents'

      res.locals.sd.CHANNEL = channel.toJSON()
      res.locals.sd.BLOCKS = blocks.toJSON()
      author = new User channel.get('user')

      res.render "index", channel: channel, blocks: blocks.models, author: author

    error: (m, err) -> next err

