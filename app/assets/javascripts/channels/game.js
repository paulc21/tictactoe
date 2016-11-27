$(document).ready(function(){
  App.game = App.cable.subscriptions.create({
    channel: "GameChannel",
    id: $('#game-grid').attr('data-game-id')
  },{
    connected: function(){},
    disconnected: function(){},
    received: function(data){
      alert("data received");
    },
    play: function(g,c){
      return this.perform('play',{ game: g, cell: c });
    }

  });
});

$(document).on('click','.game-cell',function(e){
  game = $(this).attr("data-game-id");
  cell = $(this).attr("data-cell-id");
  App.game.play(game,cell);
  e.preventDefault();
})
