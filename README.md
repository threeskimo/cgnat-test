# cgnat-test.bat
A batch file that tests to see if you are behind a carrier-grade NAT (CGNAT).  Download and run this script on a machine located within your network.  It will look up your public IP address via the Invoke-Webrequest cmdlet and then perform a traceroute back to that IP to see what hops (if any) exist and then tell you the result. If the IP in the first hop is not your public IP, it is likely you are sitting behind a carrier-grade NAT and you will not be able to perform port forwarding to allow services to be accessible outside of your network (i.e., OpenVPN, game servers such as Minecraft, Plex, etc.). 

## So what?
Carrier-grade NAT usually prevents the ISP customers from using port forwarding, because the network address translation (NAT) is usually implemented by mapping ports of the NAT devices in the network to other ports in the external interface. This is done so the router will be able to map the responses to the correct device; in carrier-grade NAT networks, even though the router at the consumer end might be configured for port forwarding, the "master router" of the ISP, which runs the CGN, will block this port forwarding because the actual port would not be the port configured by the consumer.[^1]

## Why?
Because I needed a way to check to make sure I was able to perform port forwarding in the lab environment I was working in. This test can be run manually (by determining your public IP and then tracerouting to that IP), but I wanted a script I could run to do it for me.

## Usage
Run directly from the command prompt and it will perform a test to determine if you are behind a CGNAT:
```
cgnat-test.bat
```

>**NOTE:** This script is not 100% accurate, as the test it performs is pretty basic and can't account for all different types of network configurations. It does, however, work pretty well for home networking use cases.

[^1]: https://en.wikipedia.org/wiki/Carrier-grade_NAT#:~:text=Carrier%2Dgrade%20NAT%20usually,configured%20by%20the%20consumer.
