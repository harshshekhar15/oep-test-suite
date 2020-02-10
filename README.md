# oep-test-suite
OpenEBS Enterprise Platform Test Suite


## Prerequisites
- Heapster or metrics-server should be running in kube-system.
- Litmus namespace should be absent.
- User should have access to the following repo - `www.github.com/mayadata-io/oep`.
- Github username and password of the user needs to be passed to the script as environment variables.

> Note: If you don't have a heapster or metrics-server running in your cluster, you can deploy the same from the following repo -- https://github.com/kubernetes-sigs/metrics-server

## Running the test-suite
To run the test suite, execute the following commands sequentially --
- git clone https://github.com/harshshekhar15/oep-test-suite.git
- cd oep-test-suite
- chmod 755 oep-test-suite.sh
- ./oep-test-suite.sh \<github-username> \<github-password>
> Eg - A user having github username as `oep@mayadata.io` and github password as `oepuser@123` will run the following command
>- ./oep-test-suite.sh oep@mayadata.io oepuser@123

## Result
After the test-suite completes execution the result of each test will be printed. The results of the tests will also be stored in `result.txt`.

## Viewing logs of litmus test jobs
The logs of the litmus test jobs ran during the execution of the oep-test-suite are present inside `logs/basic-sanity-checks`.
