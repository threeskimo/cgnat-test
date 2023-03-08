# cgnat-test.bat
A batch file that tests to see if you are behind a carrier-grade NAT (CGNAT), which may prevent you from performing port forwarding.  Download and run this script on a machine located within your network.  It will look up your public IP address via an Invoke-Webrequest cmdlet and then perform a tracerout back to that IP to see what hops (if any) exists. If the IP in the first hop is not your public IP, it is likely you are sitting behind a carrier-grade NAT and you will not be able to perform port forwarding to allow services to be accessible outside of your network.

## Why?
Because I needed a way to check to make sure I was able to perform port forwarding in the lab environment I was working in. This test can be run manually (by determining your public IP and then tracerouting to that IP), but I wanted a script I could run to do it for me.

## Usage
Run directly from the command prompt and it will perform a test to determine if you are behind a CGNAT:
```
cgnat-test.bat
```

>**NOTE:** This script is not a 100% accurate, as the test it performs is pretty basic and can't account for all network configurations.
