; Archivo de zona para la zona intranet.gsx

$TTL 604800
@	IN	SOA	ns.intranet.gsx. root.ns.intranet.gsx. (
			2024032601 ; Serial
			604800     ; Refresh
			86400      ; Retry
			2419200    ; Expire
			604800 )   ; Negative Cache TTL

; Definir el servidor de nombres para la zona (el servidor DNS de la DMZ)
@	IN	NS	ns.intranet.gsx.
ns	IN	A	198.18.249.254

; Definir los registros de recursos para los nombres de la topología (color verde)
router	IN	A	172.24.248.81
dhcp	IN	A	172.24.248.94
server	IN	CNAME	ns
www	IN	CNAME	ns
