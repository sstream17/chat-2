import { credential, initializeApp, messaging, auth } from "firebase-admin";
import * as functions from "firebase-functions";

initializeApp({ credential: credential.applicationDefault() });

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const sendMessage = functions.https.onRequest(async (request, response) => {
    const body = request.body;

    const payload: messaging.MessagingPayload = {
        data: {
            "sender": body.sender,
            "content": body.content
        }
    };

    const messageResponse = await messaging().sendToDevice(body.token, payload);

    functions.logger.info(messageResponse, { structuredData: true });
    response.send("Hello from Firebase!");
});

export const createAccount = functions.https.onRequest(async (request, response) => {
    const body = request.body;

    auth().createUser({
        email: body.email,
        password: body.password,
        displayName: body.username,
    })
        .then((userRecord) => {
            // See the UserRecord reference doc for the contents of userRecord.
            console.log("Successfully created new user:", userRecord.uid);
            response.status(200).send();
        })
        .catch((error) => {
            console.log("Error creating new user:", error);
        });
});
