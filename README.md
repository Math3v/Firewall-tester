## Firewall-tester
Testing script for linux kernel firewall

### Test-case file structure
Test name

Command to prepare kernel module

Command to test

Result of test (PASS|FAIL|INVALID)

Command to delete added rule

### Test results
PASS - executed command should return 0

FAIL - executed command shold NOT return 0

INVALID - invalid rule added
