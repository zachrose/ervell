#
# The client-side code for the channel header.
#
#

Backbone = require "backbone"
Backbone.$ = $
sd = require("sharify").data
Channel = require "../../models/channel.coffee"
UserBlocks = require '../../collections/user_blocks.coffee'
InfiniteView = require '../../components/pagination/infinite_view.coffee'
UserBlockCollectionView = require '../../components/block_collection/client/user_block_collection_view.coffee'

module.exports.init = ->
  blocks = new UserBlocks sd.BLOCKS,
    user_slug: sd.USER.slug

  new UserBlockCollectionView
    el: $ ".grid"
    blocks: blocks

  new InfiniteView
    context: $ ".grid"
    collection: blocks
    itemSelector: $ ".grid"
