import { auth, credential, firestore, initializeApp, messaging, } from 'firebase-admin';
import * as functions from 'firebase-functions';
import { LinkUser, } from './models/linkUser';

const MAX_USERS_WITH_NAME = 10000;
const PAD_LENGTH = Math.log(MAX_USERS_WITH_NAME) * Math.LOG10E | 0;

initializeApp({ credential: credential.applicationDefault(), });

const db = firestore();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const sendMessage = functions.https.onRequest(async (request, response) => {
    const body = request.body;

    const payload: messaging.MessagingPayload = {
        data: {
            'sender': body.sender,
            'content': body.content,
        },
    };

    const messageResponse = await messaging().sendToDevice(body.token, payload);

    functions.logger.info(messageResponse, { structuredData: true, });
    response.send('Hello from Firebase!');
});

export const onUserAdded = functions.auth.user().onCreate(async (user) => {
    const username = user.displayName;
    if (username) {
        await db.collection('usernames').doc(username).set(
            {
                'count': firestore.FieldValue.increment(1),
            },
            {
                merge: true,
            });
    }
});

export const createAccount = functions.https.onRequest(async (request, response) => {
    const body = request.body;
    const username: string = body.username;

    const sum = Array.from(username)
        .map((x) => x.codePointAt(0)!) // eslint-disable-line @typescript-eslint/no-non-null-assertion
        .reduce((a, b) => a + b);

    const usernameDoc = await db.collection('usernames').doc(username).get();

    let count = usernameDoc.data()?.count;
    if (!count) {
        count = 0;
    }
            
    const tag = (sum + count) % MAX_USERS_WITH_NAME;

    if (count === MAX_USERS_WITH_NAME) {
        response.status(400).send();
        return;
    }

    auth().createUser({
        email: body.email,
        password: body.password,
        displayName: username,
    })
        .then(async (userRecord) => {
            console.log('Successfully created new user:', userRecord.uid);
            const linkUser = new LinkUser({
                email: body.email,
                username: body.username,
                firebaseUid: userRecord.uid,
            });

            const userTagId = `${linkUser.username}:${tag.toString().padStart(PAD_LENGTH, '0')}`;

            // TODO: Set doc Id not to use Firebase UId
            await db.collection('users').doc(linkUser.firebaseUid).set({
                email: linkUser.email,
                username: linkUser.username,
                firebaseUid: linkUser.firebaseUid,
                userTagId: userTagId,
            });

            response.status(200).send();
        })
        .catch((error) => {
            console.log('Error creating new user:', error);
            response.status(400).send();
        });
});
