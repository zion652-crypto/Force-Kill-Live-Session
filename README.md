1.) AWS Console Session Revocation Kill-Switch



This automated incident response playbook immediately evicts a compromised user from the AWS Management Console and terminates active browser sessions to stop data exfiltration.








2). How the Time Condition Works




When a hacker compromises an account, changing the password does not destroy active browser cookies. This playbook forces immediate eviction using token invalidation.

The aws:TokenIssueTime key reads the creation timestamp of the session token. By pairing it with DateLessThan logic against the midnight cutoff (2026-06-18), AWS instantly denies any requests originating from tokens issued before execution. The attacker hits a wall, while clean tokens generated tomorrow bypass the rule.
