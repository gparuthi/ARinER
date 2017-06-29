<vizualize>
<div class="container">
	<div class="bgimg"></div>
	  <div class="mdl-grid">
	      <div each={cells} class="mdl-cell mdl-cell--4-col text" style="text-align: center;">
	        <h1 class={selectedClass: selected}><span class="locid" if={!who}></span><span if={who}>{who}</span></h1>
	      </div>
	    </div> 
	
		
	
</div>

<script>
var self= this
self.cells = [{id:"d", selected:false},
{id:"x"},
{id:"e", selected:true},
{id:"y", selected:false},
{id:"z", selected:false},
{id:"z", selected:false},
{id:"w", selected:false},
{id:"|", selected:false},
{id:"|", selected:false},
{id:"|", selected:false},
{id:"v", selected:false},
{id:"a", selected:false}]


updateLocations(){
	  firebase.database().ref('currentLocation/').on("value", s=>{
	  	let d = s.val()
	  	if (d){
	  		o1 = d[1]
	  		console.log(o1)
	  		_.each(self.cells, c=>{
	  			c.selected = false
	  			c.who = null
	  			if (c["id"] === o1.location){
	  				c["selected"] = true
	  				c.who = 1
	  				self.update()
	  			} 
	  		})
	  	}
	  })
	  
	}


this.on("mount", function(){
	// self.interval = setInterval(self.updateLocations, 20000)
	// self.updateLocations()
	
})
	
</script>

<style>

.bgimg {
	position: absolute;
	top: 0px;
	left: -20px;
	width: 100%;
	height: 100%;
    background-image: url('images/1.PNG');
    z-index: 100;
    opacity: 0.1; filter: alpha(opacity=40);

}

h1 {
		-o-transition:.5s;
	  -ms-transition:.5s;
	  -moz-transition:.5s;
	  -webkit-transition:.5s;
	  /* ...and now for the proper property */
	  transition:.5s;
}
	.selectedClass {
		background-color: #508C17; 
		
	}

	h1 {
		color: #edebda;
		height: 100px;
	}
	.locid{
		color: #edebda;
	}

</style>
</vizualize>