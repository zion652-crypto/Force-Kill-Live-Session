#!/bin/bash

# 1. The script stops here and asks you who to kick out
read -p "Enter the username to kick out of the console: " target_user

# 2. Delete the login profile (destroys their web password instantly)
aws iam delete-login-profile --user-name "$target_user"

# 3. Nuke any active browser sessions they are currently using
aws iam put-user-policy --user-name "$target_user" --policy-name RevokeConsoleSessions --policy-document '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "*",
      "Resource": "*",
      "Condition": {
        "DateLessThan": {"aws:TokenIssueTime": "2026-06-18T23:59:59Z"}
      }
    }
  ]
}'

echo " Web Console access terminated and login session killed for $target_user."