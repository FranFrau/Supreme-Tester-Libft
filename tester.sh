# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ffrau <ffrau@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/19 17:16:44 by ffrau             #+#    #+#              #
#    Updated: 2022/05/22 20:53:58 by ffrau            ###   ########.fr        #
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

RED="\033[31m"
IRED="\033[41m"
LGREEN="\033[32m"
NC="\033[0m"
WARNING="\033[1m\033[4m\033[35m"
CURR_PATH=$(dirname "$0")

if [ -d ${CURR_PATH}/libft-war-machine/ ]; then
	source ${CURR_PATH}/libft-war-machine/my_config.sh
fi

press_any_key(){
	printf "${LGREEN}Press any key to continue${NC}";
	read -rsn1; echo
}

end_test(){
	press_any_key
	cd ${PATH_LIBFT}
	make fclean -C ${PATH_LIBFT}
	printf "${IRED}WARNING${NC}\n${WARNING}This script use some tester made by students of the 42 network, Be aware and teste by you're own, we never know if the moulinette as been updated. See if and where it fails, understand what the testers tell's you.${NC}"
	exit
}

warmachine(){
	bash ${CURR_PATH}/libft-war-machine/grademe.sh
}

libfttest(){
	bash ${CURR_PATH}/Libftest/grademe.sh
}

libft_unit_test(){
	make f -C ${PATH_LIBFT}/../libft-unit-test
}

libfttester(){
 	make a -C ${PATH_LIBFT}/libftTester
}

libft_tester(){
	cd ${PATH_LIBFT}/../libft_tester
	bash launch.sh
}

valid_params(){
	if [ $1 ]; then
		case $1 in
			'1')
				warmachine
				end_test
				;;
			'2')
				libft_unit_test
				end_test
				;;
			'3')
				libfttest
				end_test
				;;
			'4')
				libfttester
				end_test
				;;
			'5')
				libft_tester
				end_test
				;;
			"list")
				printf "${RED}/************************/\n"
				printf "${RED}/* ${LGREEN}sh tester.sh list	${RED}*/\n"
				printf "${RED}/* ${LGREEN}sh tester.sh clear	${RED}*/\n"
				printf "${RED}/* ${LGREEN}sh tester.sh [1-5]	${RED}*/\n"
				printf "${RED}/************************/\n${NC}"
				exit
				;;
			"clear")
				rm -rf ${CURR_PATH}/libft-war-machine
				rm -rf ${CURR_PATH}/Libftest
				rm -rf ${PATH_LIBFT}/../libft-unit-test
				rm -rf ${PATH_LIBFT}/libftTester
				rm -rf ${PATH_LIBFT}/../libft_tester
				exit
				;;
		esac
	else
		warmachine
		press_any_key
		libft_unit_test
		press_any_key
		libfttest
		press_any_key
		libfttester
		press_any_key
		libft_tester
	fi
}

download_repos(){
	if [ ! -d ${CURR_PATH}/libft-war-machine/ ]; then
		printf "${LGREEN}Installing the y3ll0w42 tester..."${NC}; echo
		git clone https://github.com/y3ll0w42/libft-war-machine
		clear
		bash ${CURR_PATH}/libft-war-machine/grademe.sh
		open ${CURR_PATH}/libft-war-machine/my_config.sh
		printf "Your current path is $PWD\n"
		printf "${IRED}WARNING${NC}\n${WARNING}This script use some tester made by students of the 42 network, Be aware and teste by you're own, we never know if the moulinette as been updated. See if and where it fails, understand what the testers tell's you.${NC}"
		exit
	fi

	if [ ! -f ${PATH_LIBFT}/libft.h ]; then
		printf "You're an iditot, check the path into \"/libft-war-machine/my_config.sh\" and then start this script...\n"
		printf "Your current path is $PWD\n"
		open ${CURR_PATH}/libft-war-machine/my_config.sh
		exit
	fi

	if [ ! -d ./]Libftest/ ]; then
		printf ${LGREEN}"Installing the jtoty tester..."${NC}; echo
		git clone https://github.com/jtoty/Libftest.git
		cp ./libft-war-machine/my_config.sh ${CURR_PATH}/Libftest/my_config.sh 
		clear
	fi
	
	if [ ! -d ${PATH_LIBFT}/libftTester ]; then
		printf ${LGREEN}"Installing the Tripouille tester..."${NC}; echo 
		git clone https://github.com/Tripouille/libftTester.git
		mv ${CURR_PATH}/libftTester ${PATH_LIBFT}/libftTester
		clear
	fi

	if [ ! -d ${PATH_LIBFT}/../libft-unit-test ]; then	
		printf ${LGREEN}"Installing the alelievr tester..."${NC}; echo 
		git clone https://github.com/alelievr/libft-unit-test.git
		mv ${CURR_PATH}/libft-unit-test ${PATH_LIBFT}/../libft-unit-test
		clear
	fi
	
	if [ ! -d ${PATH_LIBFT}/../libft_tester ]; then
		printf ${LGREEN}"Installing the adrossig tester..."${NC}; echo 
		git clone https://github.com/adrossig/libft_tester.git
		mv ${CURR_PATH}/libft_tester ${PATH_LIBFT}/../
		clear
	fi
}

clear
if [ $1 ] && ([ $1 == "clear" ] || [ $1 == "list" ]); then
	valid_params $1
fi
download_repos
valid_params $1
end_test