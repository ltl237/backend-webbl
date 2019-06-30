App.room = App.cable.subscriptions.create("EntriesChannel", {

  // # Called when the subscription is ready for use on the server
  connected: () => {
    console.log("connected");
  },

  // # Called when the subscription has been terminated by the server
  disconnected: () => {
    console.log("DISconnected");
  },

  // # Called when there's incoming data on the websocket for this channel
  received: (data) => {
    console.log(data);
  }
})
