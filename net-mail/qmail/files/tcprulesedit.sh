#!/bin/sh

#
#Script to edit /etc/tcp.smtp to control mail relay from your machine using wmail
#Script by Parag Mehta <pm@gentoo.org>
#

vi /etc/tcp.smtp
/usr/bin/tcprules /etc/tcp.smtp.cdb /etc/tcp.smtp.tmp < /etc/tcp.smtp

