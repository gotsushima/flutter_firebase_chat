const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions
  .region("asia-northeast1")
  .firestore.document("chat/{messageId}")
  .onCreate(async (snapshot, context) => {
    return admin.messaging().sendToTopic("chat", {
      notification: {
        title: "New Message",
        body: snapshot.data()["text"],
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });
