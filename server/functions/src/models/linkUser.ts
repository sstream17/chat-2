type LinkUserArgs = {
    email: string;
    username: string;
    firebaseUid: string;
}

export class LinkUser {
    /**
     * The user's primary email, if set.
     */
    email: string;
    /**
     * The user's display name.
     */
    username: string;
    /**
     * The user's firebase `uid`.
     */
     firebaseUid: string;

     constructor(args: LinkUserArgs) {
         this.email = args.email;
         this.username = args.username;
         this.firebaseUid = args.firebaseUid;
     }
}