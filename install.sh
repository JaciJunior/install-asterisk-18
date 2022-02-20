#!/bin/bash

echo -e "\n Atualizando repositorios DEBIAN \n"
if ! apt-get update
 then
   echo “\n Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list”
 exit 1
fi


echo -e "\n Atualizando pacotes DEBIAN \n"
if ! apt-get upgrade -y
 then
   echo “\n Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list”
 exit 1
fi


echo -e "\n Atualizando pacotes ja instalados DEBIAN \n"
if ! apt-get dist-upgrade -y
 then
   echo “\n Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list”
 exit 1
fi


echo -e "\n instalando Headers do kernel \n"
if ! apt-get install -y Linux-headers-`uname -r`
 then
   echo “\n Não foi possível instalar os headers ”
 exit 1
fi


echo -e "\n instalando SSH \n"
if ! apt-get install -y ssh
 then
   echo “\n Não foi possível instalar ssh”
 exit 1
fi


echo -e "\n instalando make  \n"
if ! apt-get install -y make
 then
   echo “\n Não foi possível instalar make ”
 exit 1
fi


echo -e "\n instalando gcc \n"
if ! apt-get install -y gcc
 then
   echo “\n Não foi possível instalar gcc ”
 exit 1
fi


echo -e "\n instalando g++ \n"
if ! apt-get install -y g++
 then
   echo “\n Não foi possível instalar g++ ”
 exit 1
fi


echo -e "\n instalando libgtk2.0-dev \n"
if ! apt-get install -y libgtk2.0-dev
 then
   echo “\n Não foi possível instalar libgtk ”
 exit 1
fi


echo -e "\n instalando libnew \n"
if ! apt-get install -y libnewt-dev
 then
   echo “\n Não foi possível instalar libnew ”
 exit 1
fi


echo -e "\n instalando libxml \n"
if ! apt-get install -y libxml2-dev
 then
   echo “\n Não foi possível instalar libxml ”
 exit 1
fi


echo -e "\n instalando libcurses \n"
if ! apt-get install -y libncurses5-dev
 then
   echo “\n Não foi possível instalar libcurses”
 exit 1
fi


echo -e "\n instalando libcurses \n"
if ! apt-get install -y libncurses5-dev
 then
   echo “\n Não foi possível instalar libcurses”
 exit 1
fi


echo -e "\n instalando libz \n"
if ! apt-get install -y libz-dev
 then
   echo “\n Não foi possível instalar libz”
 exit 1
fi


echo -e "\n instalando libssl \n"
if ! apt-get install -y libssl-dev
 then
   echo “\n Não foi possível instalar libssl”
 exit 1
fi


echo -e "\n instalando libsqlite3 \n"
if ! apt-get install -y libsqlite3-dev
 then
   echo “\n Não foi possível instalar libsqllite”
 exit 1
fi



echo -e "\n instalando uuid \n"
if ! apt-get install -y uuid-dev
 then
   echo “\n Não foi possível instalar uuid”
 exit 1
fi


echo -e "\n instalando uuid \n"
if ! apt-get install -y uuid
 then
   echo “\n Não foi possível instalar uuid”
 exit 1
fi


echo -e "\n instalando libjanso \n"
if ! apt-get install -y libjansson-dev
 then
   echo “\n Não foi possível instalar libjansson”
 exit 1
fi

echo -e "\n instalando libedit \n"
if ! apt-get install -y libedit-dev
 then
   echo “\n Não foi possível instalar libied”
 exit 1
fi

echo -e "\n instalando GITt \n"
if ! apt-get install -y git
 then
   echo “\n Não foi possível instalar git”
 exit 1
fi

echo -e "\n INSTALANDO PHP \n"
sudo apt -y install lsb-release apt-transport-https ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt update
sudo apt -y install php7.4-{bcmath,bz2,intl,gd,mbstring,mysql,zip,curl}


echo -e "\n INSTALANDO MYSQL CLIENT \n"
apt-get -y install mysql-client


echo -e "\n DOWNLOAD ASTERISK E DEPENDENCIAS\n"


mkdir ~/asterisk
cd ~/asterisk
wget -cO - https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18.10.0.tar.gz > asterisk.tar.gz
wget -cO - https://downloads.asterisk.org/pub/telephony/libpri/libpri-1.6.0.tar.gz > libpri.tar.gz
wget -cO - https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-3.1.0+3.1.0.tar.gz > dahdi.tar.gz


echo -e "\n DESCOMPACTANDO DOWNLOADS \n"
tar -zxvf asterisk.tar.gz
tar -zxvf libpri.tar.gz
tar -zxvf dahdi.tar.gz

echo -e "\n INSTALANDO DAHDI\n"
cd ~/asterisk/dahdi-linux-complete-3.1.0+3.1.0
make all
make install


echo -e "\n INSTALANDO LIBPRI\n"
cd ~/asterisk/libpri-1.6.0
make clean
make
make install

echo -e "\n INSTALANDO ASTERISK\n"
cd ~/asterisk/asterisk-18.10.0
./configure
make
make install
make samples
make config
/etc/init.d/asterisk
make install-logrotate

echo -e "\n INICIANDO SERVICO ASTERISK\n"
/etc/init.d/asterisk start
echo -e "\n INSTALACAO FINALIZADA\n"
echo -e "\n REINICIANDO \n"

sleep 5
reboot -h now
