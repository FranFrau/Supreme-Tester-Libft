# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ffrau <ffrau@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/19 17:16:44 by ffrau             #+#    #+#              #
#    Updated: 2022/01/20 10:40:25 by ffrau            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#The path of the libftest folder (https://github.com/jtoty/Libftest.git)

clear
if [ ! -d ./Libftest/ ]; then
	echo "Installing the jtoty tester..."
	git clone https://github.com/jtoty/Libftest.git
	clear
	bash $(dirname "$0")/Libftest/grademe.sh
	exit
fi

source $(dirname "$0")/Libftest/my_config.sh
echo ${PATH_LIBFT}
if [ ${PATH_LIBFT} == "/Users/$USER/libft" ]; then
	echo "Before start, make sure that you've wrote the right path of LIBFT, you can find the right path with *pwd* command in the libft folder"
	read -rsn1 -p"Press any key to continue"
	exit
else
	if [ ! -d ${PATH_LIBFT}/libftTester ]; then
		echo "Installing the Tripouille tester..."
		git clone https://github.com/Tripouille/libftTester.git
		mv $(dirname "$0")/libftTester ${PATH_LIBFT}/libftTester
		clear
	fi
	if [ ! -d ${PATH_LIBFT}/../libft-unit-test ]; then
		echo "Installing the alelievr tester..."
		git clone https://github.com/alelievr/libft-unit-test.git
		mv $(dirname "$0")/libft-unit-test ${PATH_LIBFT}/../libft-unit-test
		clear
	fi
	bash $(dirname "$0")/Libftest/grademe.sh
	read -rsn1 -p"Press any key to continue";echo
	cd ${PATH_LIBFT}/../libft-unit-test
	make f Makefile
	read -rsn1 -p"Press any key to continue";echo
	cd ${PATH_LIBFT}/libftTester
	make a Makefile
fi
