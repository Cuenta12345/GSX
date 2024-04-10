
Pruebas de consultas directas a todas las zonas


; <<>> DiG 9.16.48-Debian <<>> +search ns
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47178
;; flags: qr rd ra; QUERY: 1, ANSWER: 13, AUTHORITY: 0, ADDITIONAL: 27

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: f4fa17e39c7b76af010000006613aa6d84249dd5c44f345c (good)
;; QUESTION SECTION:
;.				IN	NS

;; ANSWER SECTION:
.			516885	IN	NS	i.root-servers.net.
.			516885	IN	NS	h.root-servers.net.
.			516885	IN	NS	b.root-servers.net.
.			516885	IN	NS	j.root-servers.net.
.			516885	IN	NS	k.root-servers.net.
.			516885	IN	NS	c.root-servers.net.
.			516885	IN	NS	d.root-servers.net.
.			516885	IN	NS	f.root-servers.net.
.			516885	IN	NS	g.root-servers.net.
.			516885	IN	NS	l.root-servers.net.
.			516885	IN	NS	e.root-servers.net.
.			516885	IN	NS	a.root-servers.net.
.			516885	IN	NS	m.root-servers.net.

;; ADDITIONAL SECTION:
a.root-servers.net.	516885	IN	A	198.41.0.4
b.root-servers.net.	516885	IN	A	170.247.170.2
c.root-servers.net.	516885	IN	A	192.33.4.12
d.root-servers.net.	516885	IN	A	199.7.91.13
e.root-servers.net.	516885	IN	A	192.203.230.10
f.root-servers.net.	516885	IN	A	192.5.5.241
g.root-servers.net.	516885	IN	A	192.112.36.4
h.root-servers.net.	516885	IN	A	198.97.190.53
i.root-servers.net.	516885	IN	A	192.36.148.17
j.root-servers.net.	516885	IN	A	192.58.128.30
k.root-servers.net.	516885	IN	A	193.0.14.129
l.root-servers.net.	516885	IN	A	199.7.83.42
m.root-servers.net.	516885	IN	A	202.12.27.33
a.root-servers.net.	516885	IN	AAAA	2001:503:ba3e::2:30
b.root-servers.net.	516885	IN	AAAA	2801:1b8:10::b
c.root-servers.net.	516885	IN	AAAA	2001:500:2::c
d.root-servers.net.	516885	IN	AAAA	2001:500:2d::d
e.root-servers.net.	516885	IN	AAAA	2001:500:a8::e
f.root-servers.net.	516885	IN	AAAA	2001:500:2f::f
g.root-servers.net.	516885	IN	AAAA	2001:500:12::d0d
h.root-servers.net.	516885	IN	AAAA	2001:500:1::53
i.root-servers.net.	516885	IN	AAAA	2001:7fe::53
j.root-servers.net.	516885	IN	AAAA	2001:503:c27::2:30
k.root-servers.net.	516885	IN	AAAA	2001:7fd::1
l.root-servers.net.	516885	IN	AAAA	2001:500:9f::42
m.root-servers.net.	516885	IN	AAAA	2001:dc3::35

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:25 UTC 2024
;; MSG SIZE  rcvd: 851


; <<>> DiG 9.16.48-Debian <<>> +search server
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 25693
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: d593c60c76db282f010000006613aa6eee3c3c68fe93b93f (good)
;; QUESTION SECTION:
;server.intranet.gsx.		IN	A

;; ANSWER SECTION:
server.intranet.gsx.	604800	IN	CNAME	ns.intranet.gsx.
ns.intranet.gsx.	604800	IN	A	198.18.249.254

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 109


; <<>> DiG 9.16.48-Debian <<>> +search www
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2969
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: ed0ca4df0da33acc010000006613aa6e64983d15e980e504 (good)
;; QUESTION SECTION:
;www.intranet.gsx.		IN	A

;; ANSWER SECTION:
www.intranet.gsx.	604800	IN	CNAME	ns.intranet.gsx.
ns.intranet.gsx.	604800	IN	A	198.18.249.254

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 106


; <<>> DiG 9.16.48-Debian <<>> +search router
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 28878
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: b9cddab1365bbf79010000006613aa6eff9587063936eb67 (good)
;; QUESTION SECTION:
;router.intranet.gsx.		IN	A

;; ANSWER SECTION:
router.intranet.gsx.	604800	IN	A	172.24.248.81

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 92


; <<>> DiG 9.16.48-Debian <<>> +search dhcp
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49429
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 110e500774e42c9c010000006613aa6ed50838eb421acdb1 (good)
;; QUESTION SECTION:
;dhcp.intranet.gsx.		IN	A

;; ANSWER SECTION:
dhcp.intranet.gsx.	604800	IN	A	172.24.248.94

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 90


; <<>> DiG 9.16.48-Debian <<>> +recurse tinet.cat
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 22586
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 0ec38b3ed91153c7010000006613aa6e637597d53b389004 (good)
;; QUESTION SECTION:
;tinet.cat.			IN	A

;; ANSWER SECTION:
tinet.cat.		83978	IN	A	195.77.216.137

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 82


Pruebas de consultas inversas a todas las zonas


; <<>> DiG 9.16.48-Debian <<>> +search -x 198.18.249.254
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18428
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 671c91ab5a82ecfe010000006613aa6e1b7c3c7990c44c7f (good)
;; QUESTION SECTION:
;254.249.18.198.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
254.249.18.198.in-addr.arpa. 604800 IN	PTR	ns.dmz.gsx.

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 108


; <<>> DiG 9.16.48-Debian <<>> +search -x 198.18.248.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13394
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: bb719c32c4226c2b010000006613aa6ec89d51837f167ffd (good)
;; QUESTION SECTION:
;1.248.18.198.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
1.248.18.198.in-addr.arpa. 604800 IN	PTR	router.dmz.gsx.

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 110


; <<>> DiG 9.16.48-Debian <<>> +search -x 172.24.248.81
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49892
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 09213ad23ab47a6a010000006613aa6eb506a85b64d08cef (good)
;; QUESTION SECTION:
;81.248.24.172.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
81.248.24.172.in-addr.arpa. 604800 IN	PTR	router.intranet.gsx.

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 116


; <<>> DiG 9.16.48-Debian <<>> +search -x 172.24.248.94
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 3426
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 5f09f65670c13d12010000006613aa6e715a6f33b80a66b2 (good)
;; QUESTION SECTION:
;94.248.24.172.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
94.248.24.172.in-addr.arpa. 604800 IN	PTR	dhcp.intranet.gsx.

;; Query time: 0 msec
;; SERVER: 198.18.249.254#53(198.18.249.254)
;; WHEN: Mon Apr 08 08:27:26 UTC 2024
;; MSG SIZE  rcvd: 114


Pruebas de ping de extremo a extremo

PING ns.intranet.gsx (198.18.249.254) 56(84) bytes of data.
64 bytes from ns.dmz.gsx (198.18.249.254): icmp_seq=1 ttl=63 time=0.024 ms

--- ns.intranet.gsx ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.024/0.024/0.024/0.000 ms
PING ns.intranet.gsx (198.18.249.254) 56(84) bytes of data.
64 bytes from ns.dmz.gsx (198.18.249.254): icmp_seq=1 ttl=63 time=0.024 ms

--- ns.intranet.gsx ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.024/0.024/0.024/0.000 ms
PING ns.intranet.gsx (198.18.249.254) 56(84) bytes of data.
64 bytes from ns.dmz.gsx (198.18.249.254): icmp_seq=1 ttl=63 time=0.022 ms

--- ns.intranet.gsx ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.022/0.022/0.022/0.000 ms
PING router.intranet.gsx (172.24.248.81) 56(84) bytes of data.
64 bytes from router.intranet.gsx (172.24.248.81): icmp_seq=1 ttl=64 time=0.018 ms

--- router.intranet.gsx ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.018/0.018/0.018/0.000 ms
PING dhcp.intranet.gsx (172.24.248.94) 56(84) bytes of data.
64 bytes from dhcp.intranet.gsx (172.24.248.94): icmp_seq=1 ttl=64 time=0.047 ms

--- dhcp.intranet.gsx ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.047/0.047/0.047/0.000 ms
PING google.com (142.250.200.142) 56(84) bytes of data.
64 bytes from mad41s14-in-f14.1e100.net (142.250.200.142): icmp_seq=1 ttl=114 time=15.9 ms

--- google.com ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 15.865/15.865/15.865/0.000 ms
