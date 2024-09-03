import { defineStorage } from "@aws-amplify/backend";

export const storage = defineStorage({
    name: "diaryEntryImageBucket",
    access: (allow) => ({
        "entryImages/*": [allow.authenticated.to(["read", "write"])],
    }),
});