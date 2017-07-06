

<vizualize>
<div class="container">
	<div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
            <svg each={data} fill={color} width="200px" height="200px" viewBox="0 0 1 1" class="demo-chart mdl-cell mdl-cell--4-col mdl-cell--3-col-desktop">
              <use xlink:href="#piechart" mask="url(#piemask)" />
              <text x="0.5" y="0.5" font-family="Roboto" font-size="0.3" fill="white" text-anchor="middle" dy="0.1">{value}<tspan font-size="0.1" dy="-0.07">{unit}</tspan></text>
            </svg>
	
		<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" style="position: fixed; left: -1000px; height: -1000px;">
        <defs>
          <mask id="piemask" maskContentUnits="objectBoundingBox">
            <circle cx=0.5 cy=0.5 r=0.49 fill="white" />
            <circle cx=0.5 cy=0.5 r=0.40 fill="black" />
          </mask>
          <g id="piechart">
            <circle cx=0.5 cy=0.5 r=0.5 />
            <path d="M {getM1()} {getM1()} {getM1()} 0 A 0.5 0.5 0 0 1 0.95 0.28 z" stroke="none" fill="rgba(255, 255, 255, 0.75)" />
          </g>
        </defs>
      </svg>
	
</div>

<script>
vizTag = this
var self = this
self.data = [{value: 120, color:"#FFA005",unit: "F"},  
			{value: 100, color:"#E8520C",unit: "BPM"}, 
			{value: 100, color:"#DD0CE8",unit: "ml"}, 
			{value: 100, color:"rgba(0, 255, 255, 0.75)",unit: "mmHg"}]

self.m1 = 0.5

getM1(){
	return self.m1
}

this.on("mount", function(){
	// self.interval = setInterval(self.updateLocations, 20000)
	// self.updateLocations()
	setInterval(function(){
		self.m1+=0.05
		if (self.m1>0.75)
			self.m1 = 0.5
		console.log(self.m1)
		self.update()
	}, 1000)
})

updateVals(d, i){
	self.data[i].value = d
	self.update()
}
	
</script>

<style>
.demo-charts {
	background-color: black !important;
}
.container {
	width: 100%;
	height: 100%;
	background-color: black !important;
}

</style>
</vizualize>