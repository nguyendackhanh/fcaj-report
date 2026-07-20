---
title : "Update template.yaml"
date: 2026-06-30
weight : 1
chapter : false
pre : " <b> 5.3.1. </b> "
---

#### Purpose

CloudFormation needs to know where the Lambda deployment package is stored. Because the backend package was uploaded to S3, update the `CodeUri` values in `template.yaml` before creating the stack.

#### Steps

1. Open `template.yaml` in the backend folder using VS Code or another editor.
2. Use `Ctrl + F` to search for:

```yaml
CodeUri: dist/
```

3. Replace each `dist/` value with the S3 object URL copied from the backend package.

Example:

```yaml
CodeUri: https://buketbackend.s3.ap-southeast-1.amazonaws.com/backend.rar
```

4. Save the file.

#### Notes

- The template contains multiple Lambda functions, so update every `CodeUri` occurrence.
- The object URL must point to the backend package uploaded to S3.
- Keep the file saved locally because it will be uploaded to CloudFormation in the next step.