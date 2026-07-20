---
title : "Enable static website hosting"
date: 2026-06-30
weight : 3
chapter : false
pre : " <b> 5.4.3. </b> "
---

#### Enable website hosting

1. Open the frontend S3 bucket.
2. Go to the **Properties** tab.
3. Scroll to **Static website hosting** and choose **Edit**.
4. Select **Enable**.
5. Choose **Host a static website**.
6. Enter the following values:
   - **Index document:** `index.html`
   - **Error document:** `index.html`
7. Save changes.

![Enable static website hosting](/images/5-Workshop/event-portal/06-enable-static-website-hosting.png)

#### Copy website endpoint

After enabling hosting, copy the **Bucket website endpoint**. This URL will be used to access the deployed frontend.

![Copy website endpoint](/images/5-Workshop/event-portal/07-copy-website-endpoint.png)