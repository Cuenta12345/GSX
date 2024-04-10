; Archivo de zona para la zona dmz.gsx

$TTL 604800
@	IN	SOA	ns.dmz.gsx. root.ns.dmz.gsx. (
			2024032601 ; Serial
			604800     ; Refresh
			86400      ; Retry
			2419200    ; Expire
			604800 )   ; Negative Cache TTL

; Definir el servidor de nombres para la zona
@	IN	NS	ns.dmz.gsx.
ns	IN	A	198.18.249.254

; Definir los registros de recursos para los nombres de la topología (color verde)
router	IN	A	198.18.248.1
server	IN	CNAME		ns
www	IN	CNAME		ns
