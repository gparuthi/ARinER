<app>
  <!-- Simple header with fixed tabs. -->
 <div>
   Test
 </div>

  <script>
    appTag = this
    var self = this
    self.userId  = "someuser"
 
    self.loading = true


    this.on("mount", function(){
      // route.exec()
      window.onbeforeunload = function () {
          appTag.log("Exit")
      };
    })

    click(e){
      // console.log(e.item);
      // route(e.item.id)
    }
    
  

    logSessionInfo(){
      $.getJSON('https://freegeoip.net/json/?callback=?', function(data) {
        data.windowlocation = window.location.href;
        appTag.log("Opened", JSON.parse(JSON.stringify(data)));
      });
    }
    
    log(m, data){
      data = data || {}
      var timestamp = new moment()
      var saveObject = {text: "DIARY | "+m, time: timestamp.format(), data:data, userId: appTag.userId}
      console.log("[DIARY-LOG]["+timestamp.format("hh:mm")+"] " + m);
      if (!self.onlyview)
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
