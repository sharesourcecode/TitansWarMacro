_online () {
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/online" -o user_agent="$(shuf -n1 .ua)")
	NPG=$(echo $SRC | sed 's/href=/\n/g' | grep 'online/all/' | head -n6 | tail -n1 | cut -d\' -f2 | cut -d\/ -f4)
	echo "Searching on $NPG Pages"
	DATE1=`date +%H:%M:%S`
	>k
	for num in `seq $NPG -1 6`; do w3m -dump $URL/online/all/$num -o user_agent="$(shuf -n1 .ua)" | head -18 | tail -16 >>k; grep '<< < 1 ' k && >k; done
	w3m -dump $URL/online/all/5 -o user_agent="$(shuf -n1 .ua)" | head -18 | tail -16 >> k
	grep ' 4 5 ' k || >k
	w3m -dump $URL/online/all/4 -o user_agent="$(shuf -n1 .ua)" | head -18 | tail -16 >> k
	grep ' 3 4 ' k || >k
	w3m -dump $URL/online/all/3 -o user_agent="$(shuf -n1 .ua)" | head -18 | tail -16 >> k
	grep ' 2 3 ' k || >k
	w3m -dump $URL/online/all/2 -o user_agent="$(shuf -n1 .ua)" | head -18 | tail -16 >> k
	grep ' 1 2 ' k || >k
	w3m -dump $URL/online/all/1 -o user_agent="$(shuf -n1 .ua)" | head -18 | tail -16 >> k
	grep ' 1 ' k || >k
	grep '-' k >all.txt
	clear
	sed -i "/Overmobile/d" all.txt
	sed -i "/Onlinehp/d" all.txt
	sed -i "/,/d" all.txt
	sed -i "/\<</d" all.txt
	sed -i "/\ |/d" all.txt
	sed -i "/\[user/d" all.txt
	sed -i "/\[arrow/d" all.txt
	sed -i "/\ feed/d" all.txt
	sed -i "/\:/d" all.txt
	sed -i "/\!/d" all.txt
	sed -i "/\+/d" all.txt
	sort -u all.txt -o all.txt
	cat all.txt | sed "s, ,~,g" | sed "s,',_,g"  >w
	cat w >y; sed -i "/_/d" y

	echo -e "[br]$DATE1 -> `date +%H:%M:%S` `date +%d\/%m\/%Y`" >send.txt
	echo -e "[br][hr]$NPG páginas Online" >>send.txt
	echo -e "[br]Total Online: `cat w | grep '~-~' | wc -l`" >>send.txt
	STOPED=`cat w | grep "_~" | wc -l`
	ACTIVE=`cat y | wc -l`
	echo -e "[br]Ativos: $ACTIVE - Inativos: $STOPED" >>send.txt
	STOPED0=`cat w | grep "\[0]" | grep "_~" | wc -l`
	ACTIVE0=`cat y | grep "\[0]" | wc -l`
	echo -e "[br][hr]Asuras ativos: $ACTIVE0 - Asuras inativos: $STOPED0" >>send.txt
	STOPED1=`cat w | grep "\[1]" | grep "_~" | wc -l`
	ACTIVE1=`cat y | grep "\[1]" | wc -l`
	echo -e "[br]Bóreas ativos: $ACTIVE1 - Bóreas inativos: $STOPED1" >>send.txt
	echo -e "[br][hr]Guerreiros: `cat k | grep ' Guerreiro' | wc -l`" >>send.txt
	echo -e "[br]Coliseu: `cat y | grep 'Coliseu' | grep -v 'clã' | wc -l`" >>send.txt
	echo -e "[br]Configuração: `cat k | grep ' Configura' | wc -l`" >>send.txt
	echo -e "[br]Fóruns: `cat k | grep 'Fórum' | wc -l`" >>send.txt
	echo -e "[br]Chats: `cat y | grep '~Conversar' | wc -l`" >>send.txt
	echo -e "[br]Caixa de correio: `cat all.txt | grep ' de correio' | wc -l`" >>send.txt

	echo -e "[br][hr]adm: `cat all.txt | grep 'Omsupport'`" >>send.txt
	echo -e "[br]mod: `cat all.txt | grep 'OMEGA SUPREME'`" >>send.txt
	echo -e "[br]mod: `cat all.txt | grep 'King Atila'`" >>send.txt
	echo -e "[br]mod: `cat all.txt | grep 'Tsuki Negro'`" >>send.txt
	echo -e "[br]mod: `cat all.txt | grep 'White Star'`" >>send.txt
#edit
	_edit () {
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/titans/changeRoom" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed "s/value\=/value\=\n/g" | grep '\<table' | cut -d\" -f2 | head -n1)
		SND2="Mudar"
		echo -e "error=$ACCESS&name="$name"&text="$(cat send.txt)"&send_message=$SND2" >edit.txt
		SRC=$(w3m -debug -post edit.txt -dump_source -o accept_encoding=='*;q=0' "$URL/forum/topic/$TID/red" -o user_agent="$(shuf -n1 .ua)")
	}
	TID=99347
	name="Resumo $(date +%H:%M:%S) $(date +%d-%m-%Y)"
	_edit && \
	echo -e "`cat y | grep 'Coliseu' | grep -v 'clã' | sed "s,~, ,g" | sed "s,Coliseu,Coliseu[br],g"`" > send.txt
	TID=99378
	name="Coliseu $(date +%H:%M:%S) $(date +%d-%m-%Y)"
	_edit && \
	echo -e "`cat all.txt | grep ' de correio' | sed "s,~, ,g" | sed "s,correio,correio[br],g"`" > send.txt
	TID=99380
	name="Caixa de correio $(date +%H:%M:%S) $(date +%d-%m-%Y)"
	_edit && \
	echo -e "`cat y | grep '~Conversar' | sed "s,~, ,g" | sed "s,Conversar,Conversar[br],g"`" > send.txt
	TID=99381
	name="Chats $(date +%H:%M:%S) $(date +%d-%m-%Y)"
	_edit && \
	echo -e "`cat all.txt | grep 'Fórum' | sed "s,~, ,g" | sed "s,Fórum,Fórum[br],g"`" > send.txt
	TID=99382
	name="Fóruns $(date +%H:%M:%S) $(date +%d-%m-%Y)"
	_edit

	rm k w y
}
