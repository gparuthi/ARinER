<app>
  <!-- Simple header with fixed tabs. -->
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header
            mdl-layout--fixed-tabs">
  <header class="mdl-layout__header">
    
    <!-- Tabs -->
    <div class="mdl-layout__tab-bar mdl-js-ripple-effect ">
      <a href={"#"+id} onclick={click} each={data} class={mdl-layout__tab:true, is-active:is_active}>{title}</a>
    </div>
  </header>
  
  <main class="mdl-layout__content">
    <section class="mdl-layout__tab-panel is-active"  id="logs">
      <div class="page-content" hide={page.id != "logs"}>
        <clogs showeventlabels=true loadfrom="logs"></clogs>
      </div>
    </section>
    <!-- <section class="mdl-layout__tab-panel is-active"  id="clogs">
      <div class="page-content" hide={page.id != "clogs"}>
        <clogs loadfrom="clogs"></clogs>
      </div>
    </section>
    <section class="mdl-layout__tab-panel is-active"  id="devices">
      <div class="page-content" hide={page.id != "devices"}>
        <devices></devices>
      </div>
    </section>-->
    <section class="mdl-layout__tab-panel is-active"  id="vizualize">
      <div class="page-content" hide={page.id != "vizualize"}>
        <vizualize></vizualize>
      </div>
    </section> 
  </main>

</div>

  <script>
    appTag = this
    var self = this
    self.userId  = localStorage.getItem("userId") || "testuser"

    allLogs = {}
    allText = {}
    atags = {}

    self.logs = []
    self.userPreferences = {}

    self.data = [
      { id: "logs", title: "Events" },      
      // { id: "clogs", title: "All Logs" },
      // { id: "devices", title: "devices" },
      { id: "vizualize", title: "vizualize" },
      // { id: "settings", title: "Settings" }
    ]
    self.page = self.data[0]


    this.on("mount", function(){
      // firebase.database().ref('/').once('value',s=> appTag.log("data", s.val()))

      token = "ef33fce3cd717d454a36a04ba34eb144bd7a5ea7"
      particle = new Particle()

      //Get all events
      self.initiateEventStreams()
      
      route.exec()
    })

    initiateEventStreams(){


      particle.getEventStream({ deviceId:'2b0045000247353138383138', auth: token}).then(function(stream) {
        stream.on('event', function(data) {
          event = data
          // console.log("Event: " + data.name, event);
          if (event.name == "sensor:light"){
            var saveObject = {'device':'a', 'type': "F", "value": event.data/100*400, "published_at": event.published_at}
            // console.log(saveObject);
            self.saveSensorDataToFB('room1_temperature', saveObject)
          }
        });
      });

      particle.getEventStream({ deviceId:'28003b000447333437333039', auth: token}).then(function(stream) {
        stream.on('event', function(data) {
          event = data
          // console.log("Event: " + data.name, event);
          if (event.name == "sensor:light"){
            var saveObject = {'device':'b', 'type': "F", "value": event.data/100*400, "published_at": event.published_at}
            self.saveSensorDataToFB('room2_temperature', saveObject)
          }
        });
      });


    }

    saveSensorDataToFB(name, data){
      updates = {}
      updates['sensors/'+name+'/currentdata'] = data
      updates['sensors/'+name+'/history/'+moment().format()] = data
      firebase.database().ref().update(updates)
    }


    click(e){
      // console.log(e.item);
      route(e.item.id)
    }
    
  

    route(function(id) {
      self.page = self.data.filter(function(r) { return r.id == id })[0] || {}
      self.page.is_active = true
      self.trigger('RouteChanged', self.page)

      self.update()
      if (!id)
        route("logs")
    })
    
    log(m, data){
     data = data || {}
     var timestamp = new moment()
     var saveObject = {text: ""+m, time: timestamp.format(), data:data}
     console.log("[LOG]["+timestamp.format("hh:mm")+"] " + m);
     firebase.database().ref('logs/').push().set(saveObject)
    }
    
    checkForMDL(){
      setTimeout(function(){
        componentHandler.upgradeAllRegistered()
        componentHandler.upgradeDom()
        _.each($('.mdl-js-textfield'), function(b){b.MaterialTextfield.checkDirty()})
      }, 100)
      // componentHandler.upgradeDom() // for mdl-lite nav bar update
      
    }


  </script>

  <style>
  .strong{
    font-weight: bold;
  } 

  .mdl-layout__tab-bar {
    height: 48px;
  }
  .header{
    color: grey;
    font-size: 8pt;
    margin: 0px;
  }
  .text{

  }
  .logcontainer{
    height: 80vh;
    float:left;
    padding:0 0 0 5px;
    position:relative;
    float:left;
    border-right: 1px #f8f7f3 solid;
    /* background-color: black; */
  }
  </style>
  
</app>
