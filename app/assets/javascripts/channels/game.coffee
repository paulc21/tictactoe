App.game = App.cable.subscriptions.create "GameChannel",
  id: $('#game-grid').attr("data-game-id")

  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data)

  play: (g,c) ->
    @perform 'play', game:g, cell: c

  $(document).on 'click', '.game-cell', (event) ->
    game = $(this).attr("data-game-id")
    cell = $(this).attr("data-cell-id")
    App.game.play(game,cell)
    event.preventDefault()
