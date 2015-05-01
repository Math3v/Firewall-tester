## Firewall-tester
Testing script for linux kernel firewall

### Test-case file structure
```
Test name
Command to prepare kernel module
Command to test
Result of test (PASS|FAIL|INVALID)
Command to delete added rule
NO NEW LINE AT THE END
```
### Test results
PASS - executed command should return 0</br>
FAIL - executed command shold NOT return 0</br>
INVALID - invalid rule added</br>

## TODOS
- [ ] allow execution of multiple commands instead of one
- [ ] allow deletion of multiple rules instead of one
