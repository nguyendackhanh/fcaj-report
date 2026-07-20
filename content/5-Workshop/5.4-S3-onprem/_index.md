---
title : "Deploy frontend with Amazon S3"
date: 2026-06-30
weight : 4
chapter : false
pre : " <b> 5.4. </b> "
---

#### Overview

In this section, you deploy the frontend of the Event Portal as a static website on Amazon S3. CloudFormation already creates the frontend bucket, so you only need to configure local environment variables, build the frontend, enable public website access, and upload the generated files.

#### Content

- [Configure frontend locally](5.4.1-prepare/)
- [Configure frontend S3 bucket permissions](5.4.2-create-interface-enpoint/)
- [Enable static website hosting](5.4.3-test-endpoint/)
- [Upload frontend files and test website](5.4.4-dns-simulation/)