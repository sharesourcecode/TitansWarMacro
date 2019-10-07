#!/bin/bash
# //https://raw.githubusercontent.com/AlvesUeliton/Titans-War-Macros/master/macros.sh
# MIT License
#
# Copyright (c) 2019 Ueliton Alves Dos Santos
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# //termux on android - - - - - - - - - - - - - - - - - - - -
termux-wake-lock &> /dev/null
# //update script and dependences - - - - - - - - - - - - - -
function _update () {
	echo -e "\nLooking for updates..."
	sleep 1
	$(wget https://raw.githubusercontent.com/AlvesUeliton/Titans-War-Macros/master/macros.sh -O macros.sh) 2&>-
	#apt install w3m -y 2&>-
	echo -e "Successful updates!"
	sleep 2
}
_update
echo -e "\nFor the full version, contact me: 369540445100@wmkeeper.com"
exit
