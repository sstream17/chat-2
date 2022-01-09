import { credential, initializeApp, messaging } from "firebase-admin";
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
