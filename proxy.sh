_proxy () {
#Downlod proxy list
	unset http_proxy && \
	>bestproxy.txt; >testproxy.txt && \
	w3m -o accept_encoding=='*;q=0' -dump_source "https://m.freevpn4you.net/free-proxy.php" -o user_agent="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1" | grep -oP '(\d+\.\d+\.\d+\.\d+)' | sed 's/^.*$/&:80/' >bestproxy.txt

#test proxy list
#	echo -e "\nLooking for a better proxy...\n"
#	for proxy in `cat testproxy.txt`
#	do
#		(curl -A "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1" -s --max-time 10 -x $proxy ip-api.com/json;echo) &
#	done | grep success | grep -oP "(\d+\.\d+\.\d+\.\d+)" >>bestproxy.txt
##export better proxy
#	proxy=$(sed 's/^.*$/&:80/' bestproxy.txt | shuf -n1)
#	echo $proxy >bestproxy.txt
#	[[ -z $proxy ]] && cat testproxy.txt | head -n1 >bestproxy.txt
#	echo -e "Current proxy $proxy"
#	w3m meuip.com
#
}
