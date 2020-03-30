const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.helloWorld = functions.database.ref('cars/{id}').onWrite(evt => {
    const payload = {
        data:{
            title : 'Message from Cloud',
            body : 'This is your body',
            badge : '1',
            sound : 'default'
        }
    };

    return admin.database().ref('fcm-token').once('value').then(allToken => {
        if(allToken.val()){
            console.log('token available');
            return admin.messaging().sendtoTopic("/topics/newcars",payload);
        }else{
            console.log('No token available');
        }
    });
});