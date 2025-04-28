

# My Work for Fawry DevOps Internship

## Task 1: Building mygrep.sh Script

### What I Did
I created a script named `mygrep.sh` that acts like the `grep` command. It does these things:
- Searches for a word in a file (doesn’t care if letters are big or small).
- Uses `-n` to show line numbers with the results.
- Uses `-v` to show lines that don’t have the word.
- Uses `-vn` or `-nv` together to show line numbers for lines that don’t have the word.
- Shows an error if I don’t give a word or a file to search in.

I tested my script with a file called `testfile.txt` that has these lines:

Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three


### Files I Used
- `Q1 Custom Command (mygrep.sh)/mygrep.sh`: This is the script I wrote.
- `Q1 Custom Command (mygrep.sh)/testfile.txt`: This is the file I used for testing.

### Screenshots of My Tests
I ran these commands in the terminal and took one screenshot for all of them:
- `./mygrep.sh hello testfile.txt`
- `./mygrep.sh -n hello testfile.txt`
- `./mygrep.sh -vn hello testfile.txt` and `./mygrep.sh -nv hello testfile.txt` (to test both -vn and -nv, they give the same result)
- `./mygrep.sh -v testfile.txt` (shows error)

You can see the screenshot here: [All Commands](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/tree/main/Q1-Custo-Command-(mygrep.sh)/screenshots)

### Reflective Section
#### 1. How My Script Handles Arguments and Options
My script first checks if I gave it a word and a file to work with. If I didn’t, it shows an error message. Then it checks if I used options like `-n` or `-v` or both. It reads the file line by line and looks for the word. If I used `-n`, it shows the line number before the line. If I used `-v`, it shows the lines that don’t have the word.

#### 2. How My Structure Would Change to Support Regex or -i/-c/-l Options
To add regex, I can change `grep -qi` to `grep -E` so it can understand patterns. For `-i`, my script already does that because it ignores big or small letters. For `-c`, I can add a counter to count the lines that match and show the number at the end. For `-l`, I can make it work with many files and only show the names of files that have the word.

#### 3. What Part of the Script Was Hardest to Implement and Why
The first hard part was making `-vn` and `-nv` work the same way. I had to check each letter in the option to know if it’s `n` or `v`, and make sure they work together no matter the order. Another hard part was handling the error messages. I had to make sure the script shows the right error if I don’t give a word or a file, and it took me some time to get the checks in the right order.

## Task 2: Troubleshooting Internal Web Dashboard

### What I Did
I worked on fixing a problem where the internal web dashboard (`internal.example.com`) was not working. Users were seeing "host not found" errors even though the service was up. I followed these steps to find and fix the issue:
1. Checked if the DNS was working by comparing the local DNS server with Google DNS (`8.8.8.8`).
2. Tested if the web service was running on Port 80 or 443.
3. Wrote down all the possible reasons for the problem.
4. Suggested ways to fix each reason with Linux commands.

### Files I Used
- I didn’t create any files for this task, but I used system files like `/etc/resolv.conf` and `/etc/hosts` for troubleshooting.
- `Q2 Scenario/screenshots/dns-resolution.png`: Screenshot of DNS resolution checks.
- `Q2 Scenario/screenshots/service-reachability.png`: Screenshot of service reachability tests.
- `Q2 Scenario/screenshots/fixing-firewall-and-routing.png`: Screenshot of applying fixes for firewall and routing.
- `Q2 Scenario/screenshots/ping-test.png`: Screenshot of ping test to check server reachability.

### Screenshots of My Tests
I took screenshots for each step of my troubleshooting:
- DNS Resolution Checks: [DNS Resolution](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/raw/main/Q2%20Scenario/screenshots/dns-resolution.png)
- Service Reachability Tests: [Service Reachability](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/raw/main/Q2%20Scenario/screenshots/service-reachability.png)
- Applying Fixes for Firewall and Routing: [Fixing Firewall and Routing](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/raw/main/Q2%20Scenario/screenshots/fixing-firewall-and-routing.png)
- Ping Test for Server Reachability: [Ping Test](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/raw/main/Q2%20Scenario/screenshots/ping-test.png)

### Troubleshooting Steps
#### 1. Verify DNS Resolution
I checked if the DNS can find `internal.example.com` using these commands:
- `cat /etc/resolv.conf` to see the local DNS server.
- `nslookup internal.example.com` to test the local DNS server.
- `nslookup internal.example.com 8.8.8.8` to test Google DNS.

Both the local DNS and Google DNS gave "NXDOMAIN" (host not found). This means the problem is with the DNS setup, maybe `internal.example.com` is not added to the internal DNS server.

#### 2. Diagnose Service Reachability
Since the DNS didn’t work, I used an IP (like `192.168.10.10`) to test the service. I ran these commands:
- `curl -I http://192.168.10.10` to check Port 80.
- `curl -I https://192.168.10.10` to check Port 443.
- `telnet 192.168.10.10 80` to test if Port 80 is open.
- `telnet 192.168.10.10 443` to test if Port 443 is open.

I got "Connection refused" errors, which means the service might not be running, or the ports are blocked.

#### 3. Possible Causes of the Issue
I wrote down all the reasons why this problem might be happening:
- **DNS Problems:**
  - The local DNS server can’t find the domain.
  - The DNS settings in `/etc/resolv.conf` might be wrong.
  - The domain `internal.example.com` is not added to the internal DNS server.
  - There might be a problem with the DNS cache.
- **Network Problems:**
  - A firewall might be blocking Port 80 or 443.
  - There might be a problem with network routing.
  - The server might not be reachable on the network.
- **Service Problems:**
  - The web service might not be running.
  - The service might be running on a different port.
  - The server might be too busy to respond.

#### 4. Propose and Apply Fixes
For each reason, I explained how to check if it’s the real problem and how to fix it:

- **Local DNS Server Can’t Find the Domain:**
  - **How to Check:** If `nslookup internal.example.com` says "NXDOMAIN" but `nslookup internal.example.com 8.8.8.8` works, the local DNS server is the problem.
  - **How to Fix:** Change the DNS server to Google DNS in `/etc/resolv.conf`:

  sudo nano /etc/resolv.conf

Add: nameserver 8.8.8.8

- **Wrong DNS Settings:**
- **How to Check:** If `/etc/resolv.conf` has a DNS server that doesn’t work (like `192.168.1.1` not responding).
- **How to Fix:** Change the DNS server to `8.8.8.8` like the command above.

- **Domain Not Added to Internal DNS:**
- **How to Check:** If even Google DNS says "NXDOMAIN", the domain isn’t added to any DNS server.
- **How to Fix:** Add the domain to `/etc/hosts` for a quick fix:

sudo nano /etc/hosts

Add: 192.168.10.10 internal.example.com

- **DNS Cache Problem:**
- **How to Check:** If the DNS worked before but now it doesn’t, the cache might be the issue.
- **How to Fix:** Clear the DNS cache:

sudo systemd-resolve --flush-caches

- **Firewall Blocking Ports:**
- **How to Check:** If `telnet 192.168.10.10 80` says "Connection refused", a firewall might be blocking. I checked this with `sudo ufw status` and saw that the firewall is inactive, so this wasn’t the problem in my case.
- **How to Fix:** If the firewall was active, I would open Port 80:

sudo ufw allow 80/tcp

- **Network Routing Problem:**
- **How to Check:** I used `traceroute 192.168.10.10` to see if the path stops somewhere. In my test, the path didn’t stop but showed stars (`* * *`) after the first hop, which means the server didn’t respond. This could be because the IP is not real, or a firewall is blocking packets.
- **How to Fix:** If there was a routing issue, I would add a route (needs admin help):

sudo ip route add 192.168.10.10 via 192.168.1.1

- **Server Not Reachable:**
- **How to Check:** I used `ping 192.168.10.10` to see if the server responds. In my test, I got no reply, which means the server is not reachable. This could be because the IP is not real, or the server is down.
- **How to Fix:** Check if the server is up (needs admin access).

- **Web Service Not Running:**
- **How to Check:** If `ss -tuln | grep -E ':80|:443'` doesn’t show Port 80 or 443, the service isn’t running.
- **How to Fix:** Start the service (like Apache):

sudo systemctl start apache2

- **Service on Wrong Port:**
- **How to Check:** If `ss -tuln` shows the service on another port (like 8080), the port is wrong.
- **How to Fix:** Change the port in the service settings (for Apache):

sudo nano /etc/apache2/ports.conf

Make sure it says: Listen 80

sudo systemctl restart apache2

- **Server Too Busy:**
- **How to Check:** Use `top` to see if CPU or Memory is too high.
- **How to Fix:** Stop heavy processes (example: PID 1234):

sudo kill 1234

I tried some of these fixes (like checking the firewall, routing, and server reachability) and took screenshots of the commands I ran. I also cleared the DNS cache earlier as another fix.