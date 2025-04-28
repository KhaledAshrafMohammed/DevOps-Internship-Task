# My Work for Fawry DevOps Internship

---

## Task 1: Building `mygrep.sh` Script

### What I Did
I created a script named `mygrep.sh` that acts like the `grep` command. It does the following:
- Searches for a word in a file (case-insensitive).
- Uses `-n` to show line numbers with the results.
- Uses `-v` to show lines that don’t have the word.
- Uses `-vn` or `-nv` together to show line numbers for lines that don’t have the word.
- Shows an error if a word or a file is not provided.

**Test file example:**
```
Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three
```

### Files I Used
- `Q1 Custom Command (mygrep.sh)/mygrep.sh`: This is the script I wrote.
- `Q1 Custom Command (mygrep.sh)/testfile.txt`: This is the file I used for testing.

### Screenshots of My Tests
I ran these commands and took a screenshot for all:
```bash
./mygrep.sh hello testfile.txt
./mygrep.sh -n hello testfile.txt
./mygrep.sh -vn hello testfile.txt
./mygrep.sh -nv hello testfile.txt
./mygrep.sh -v testfile.txt  # (shows error)
```
Screenshot: [All Commands](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/tree/main/Q1-Custo-Command-(mygrep.sh)/screenshots)

### Reflective Section
#### 1. How My Script Handles Arguments and Options
- Checks if both a word and a file are provided; otherwise, shows an error.
- Detects if `-n` or `-v` or both are used, regardless of order.
- Reads the file line by line and applies the options accordingly.

#### 2. How My Structure Would Change to Support Regex or `-i`/`-c`/`-l` Options
- **Regex:** Use `grep -E` for pattern support.
- **-i:** Already implemented (case-insensitive).
- **-c:** Add a counter for matching lines.
- **-l:** Support multiple files, print only names with matches.

#### 3. What Part of the Script Was Hardest to Implement and Why
- Handling `-vn` and `-nv` the same way, regardless of order.
- Ensuring correct error messages and argument checks.

---

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
- DNS Resolution Checks: [DNS Resolution](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/blob/main/Q2%20Scenario/screenshots/DNS-Resolution.png)
- Local Server Name: [Local server Name](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/blob/main/Q2%20Scenario/screenshots/Local-Name-Server.png)
- Service Reachability Tests: [Service Reachability](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/blob/main/Q2%20Scenario/screenshots/Service-Reachability.png)
- Applying Fixes for Firewall and Routing: [Fixing Firewall and Routing](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/blob/main/Q2%20Scenario/screenshots/Fixing-Firewall-And-Routing.png)
- Ping Test for Server Reachability: [Ping Test](https://github.com/KhaledAshrafMohammed/DevOps-Internship-Task/blob/main/Q2%20Scenario/screenshots/Ping-Test.png)

### Troubleshooting Steps
#### 1. Verify DNS Resolution
I checked if the DNS can find `internal.example.com` using these commands:
```bash
cat /etc/resolv.conf
nslookup internal.example.com
nslookup internal.example.com 8.8.8.8
```
Both the local DNS and Google DNS gave "NXDOMAIN" (host not found). This means the problem is with the DNS setup, maybe `internal.example.com` is not added to the internal DNS server.

#### 2. Diagnose Service Reachability
Since the DNS didn’t work, I used an IP (like `192.168.10.10`) to test the service. I ran these commands:
```bash
curl -I http://192.168.10.10
curl -I https://192.168.10.10
telnet 192.168.10.10 80
telnet 192.168.10.10 443
```
I got "Connection refused" errors, which means the service might not be running, or the ports are blocked.

#### 3. Possible Causes of the Issue
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
  - *How to Check:*
    ```bash
    nslookup internal.example.com
    nslookup internal.example.com 8.8.8.8
    ```
    If `nslookup` with local DNS fails and with Google DNS works, the local DNS server is the problem.
  - *How to Fix:*
    Change the DNS server to Google DNS in `/etc/resolv.conf`:
    ```bash
    sudo nano /etc/resolv.conf
    # Add:
    nameserver 8.8.8.8
    ```

- **Wrong DNS Settings:**
  - *How to Check:*
    If `/etc/resolv.conf` has a DNS server that doesn’t work (like `192.168.1.1` not responding).
  - *How to Fix:*
    Change the DNS server to `8.8.8.8` as above.

- **Domain Not Added to Internal DNS:**
  - *How to Check:*
    If even Google DNS says "NXDOMAIN", the domain isn’t added to any DNS server.
  - *How to Fix:*
    Add the domain to `/etc/hosts` for a quick fix:
    ```bash
    sudo nano /etc/hosts
    # Add:
    192.168.10.10 internal.example.com
    ```

- **DNS Cache Problem:**
  - *How to Check:*
    If the DNS worked before but now it doesn’t, the cache might be the issue.
  - *How to Fix:*
    ```bash
    sudo systemd-resolve --flush-caches
    ```

- **Firewall Blocking Ports:**
  - *How to Check:*
    If `telnet 192.168.10.10 80` says "Connection refused", a firewall might be blocking. Check with:
    ```bash
    sudo ufw status
    ```
  - *How to Fix:*
    ```bash
    sudo ufw allow 80/tcp
    ```

- **Network Routing Problem:**
  - *How to Check:*
    ```bash
    traceroute 192.168.10.10
    ```
    If the path stops or shows `* * *`, there may be a routing or firewall issue.
  - *How to Fix:*
    ```bash
    sudo ip route add 192.168.10.10 via 192.168.1.1
    ```

- **Server Not Reachable:**
  - *How to Check:*
    ```bash
    ping 192.168.10.10
    ```
    If there is no reply, the server is not reachable or down.
  - *How to Fix:*
    Check if the server is up (needs admin access).

- **Web Service Not Running:**
  - *How to Check:*
    ```bash
    ss -tuln | grep -E ':80|:443'
    ```
    If Port 80 or 443 is not shown, the service isn’t running.
  - *How to Fix:*
    ```bash
    sudo systemctl start apache2
    ```

- **Service on Wrong Port:**
  - *How to Check:*
    ```bash
    ss -tuln
    ```
    If the service is on another port (like 8080), the port is wrong.
  - *How to Fix:*
    ```bash
    sudo nano /etc/apache2/ports.conf
    # Make sure it says:
    Listen 80
    sudo systemctl restart apache2
    ```

- **Server Too Busy:**
  - *How to Check:*
    ```bash
    top
    ```
    If CPU or Memory is too high, the server may be overloaded.
  - *How to Fix:*
    ```bash
    sudo kill <PID>
    ```

---

I tried some of these fixes (like checking the firewall, routing, and server reachability) and took screenshots of the commands I ran. I also cleared the DNS cache earlier as another fix.