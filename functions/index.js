var moment = require('moment-timezone');

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
const cors = require('cors')({origin: true});

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
exports.helloWorld = functions.https.onRequest((request, response) => {
	cors(request, response, () => {
		let input = request.body;

		admin.database().ref('/chats/'+ moment().format()).set({input}).then(function(){
			response.status(200).send({"result": moment().format()});
		})

		
	});
});

