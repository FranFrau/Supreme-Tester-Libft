# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ffrau <ffrau@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/19 17:16:44 by ffrau             #+#    #+#              #
#    Updated: 2022/01/23 14:30:26 by ffrau            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                                 The testers                                  #
#                                                                              #
# 1) https://github.com/jtoty/Libftest.git                                     #
# 2) https://github.com/Tripouille/libftTester.git                             #
# 3) https://github.com/alelievr/libft-unit-test.git                           #
# 4) https://github.com/adrossig/libft_tester.git                              #
# 5) https://github.com/y3ll0w42/libft-war-machine                             #
#                                                                              #
# **************************************************************************** #

ANSWER='0'
RED="\033[31m"
IRED="\033[41m"
LGREEN="\033[32m"
NC="\033[0m"
WARNING="\033[1m\033[4m\033[35m"
clear
if [ ! -d $(dirname "$0")/libft-war-machine/ ]; then
	echo "${LGREEN}Installing the y3ll0w42 tester..."${NC}; echo
	git clone https://github.com/y3ll0w42/libft-war-machine
	clear
	bash $(dirname "$0")/libft-war-machine/grademe.sh
	open $(dirname "$0")/libft-war-machine/my_config.sh
	echo ${IRED}"WARNING"${NC}
	echo ${WARNING}"This script use some tester made by students of the 42 network, Be aware and teste by you're own, we never know if the moulinette as been updated. See if and where it fails, understand what the testers tell's you."${NC}
	exit
fi

source $(dirname "$0")/libft-war-machine/my_config.sh
if [ ${PATH_LIBFT} == "../" ]; then
	echo "${IRED}WARNING${NC}\nBefore start, make sure that you've wrote the right path of LIBFT, you can find the right path with ${IRED}pwd${NC} command in the libft folder"
	read -rp "The path in the file is the default, do you want to contiue? [y/n] " $ANSWER
fi
if [ $ANSWER == 'Y' ] | [ $ANSWER == 'y' ] | [ $ANSWER == '0' ]; then

	if [ ! -f ${PATH_LIBFT}/libft.h ]; then
		echo "You're an iditot, check your path and  then start this script..."
		exit
	fi

	if [ ! -d ./]Libftest/ ]; then
		echo ${LGREEN}"Installing the jtoty tester..."${NC}; echo 
		git clone https://github.com/jtoty/Libftest.git
		clear
	fi
	
	if [ ! -d ${PATH_LIBFT}/libftTester ]; then
		echo ${LGREEN}"Installing the Tripouille tester..."${NC}; echo 
		git clone https://github.com/Tripouille/libftTester.git
		mv $(dirname "$0")/libftTester ${PATH_LIBFT}/libftTester
		clear
	fi

	if [ ! -d ${PATH_LIBFT}/../libft-unit-test ]; then	
		echo ${LGREEN}"Installing the alelievr tester..."${NC}; echo 
		git clone https://github.com/alelievr/libft-unit-test.git
		mv $(dirname "$0")/libft-unit-test ${PATH_LIBFT}/../libft-unit-test
		clear
	fi
	
	if [ ! -d ${PATH_LIBFT}/../libft_tester ]; then
		echo ${LGREEN}"Installing the adrossig tester..."${NC}; echo 
		git clone https://github.com/adrossig/libft_tester.git
		mv $(dirname "$0")/libft_tester ${PATH_LIBFT}/../
		clear
	fi

	cp ./libft-war-machine/my_config.sh prova.sh
	mv prova.sh my_config.sh
	mv $(dirname "$0")/my_config.sh $(dirname "$0")/Libftest/my_config.sh

	bash $(dirname "$0")/libft-war-machine/grademe.sh
	echo "${LGREEN}Press any key to continue"${NC};
	read -rsn1; echo

	bash $(dirname "$0")/Libftest/grademe.sh
	echo "${LGREEN}Press any key to continue"${NC};
	read -rsn1; echo

	cd ${PATH_LIBFT}/../libft-unit-test
	make f Makefile
	echo "${LGREEN}Press any key to continue"${NC};
	read -rsn1; echo
	
	cd ${PATH_LIBFT}/libftTester
 	make a Makefile
	echo "${LGREEN}Press any key to continue"${NC};
	read -rsn1; echo
	
	cd ${PATH_LIBFT}/../libft_tester
	bash launch.sh
	
	cd ${PATH_LIBFT}
	make fclean Makefile
	echo "${IRED}WARNING${NC}\n${WARNING}This script use some tester made by students of the 42 network, Be aware and teste by you're own, we never know if the moulinette as been updated. See if and where it fails, understand what the testers tell's you."${NC}
else
	exit
fi
