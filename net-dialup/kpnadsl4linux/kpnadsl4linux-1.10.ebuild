# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kpnadsl4linux/kpnadsl4linux-1.10.ebuild,v 1.1 2002/11/24 22:00:40 hannes Exp $

IUSE=""
DESCRIPTION="ADSL4Linux, a PPTP start/stop/etc. program especially for Dutch users, for gentoo."
HOMEPAGE="http://www.adsl4linux.nl/"
SRC_URI="http://home.planet.nl/~mcdon001/${P}.tar.gz
	http://www.adsl4linux.nl/download/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="virtual/glibc"
RDEPEND="sys-apps/gawk
	>=net-dialup/pptpclient-1.1.0
	>=net-dialup/ppp-2.4.0"

src_compile() {
	make || die "Make failed."
}

src_install() {
	dosbin adsl
	dodoc COPYING Changelog INSTALL README
	exeinto /etc/init.d/
	newexe init.d.adsl adsl
}

pkg_postinst() {
	einfo "\e[32;01m * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\033[0m"
	einfo "\e[31;31;01m Please do _NOT_ forget to run the following: \e[32;01m				        *\033[0m"
	einfo "\e[33;01m 'ebuild /var/db/pkg/${CATEGORY}/${P}/${P}.ebuild config' \e[32;01m* \033[0m"
	einfo "											\e[32;01m*\033[0m"
	einfo "\e[31;31;01m To start ${P} at boot type: 					        \e[32;01m*\033[0m"
	einfo "\e[33;01m 'rc-update add adsl default'							\e[32;01m*\033[0m"
	einfo "\e[32;01m * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\033[0m"
}

pkg_config() {

a4lvarconfig() {
	# Get username, password and 'phonenumber' (pc1/pc2/pc3/...)
	echo "What's your username? (ie. myname@subscription-form)"; read USERNAME;
	echo ""
	echo "What's your password?"; read PAWD;
	echo ""
	echo "If you have a subscription with multiple ip addresses, please specify your 'pc-number'? (ie. pc3) Press ENTER if you have no idea what I'm talking about."; read PCNUMBER;
	echo ""
	if [ -z ${PCNUMBER} ]; then PCNUMBER=pc1; else :; fi;
	echo "Are these, in order, your username, password and pc-number?";
	echo "username: ${USERNAME}";
	echo "password: ${PAWD}";
	echo "pc-number: ${PCNUMBER}";
	# Ask whether settings are correct and act accordingly.
	CHECK="Yes No";
	select CHCKCHCK in ${CHECK}; do
	if [ ${CHCKCHCK} = "Yes" ];
	# Get username etc. again if last try was incorrect.
	then adslconfigins;
	# Else go to the next step.
	else echo ""; echo ""; echo ""; a4lvarconfig;
	fi
	done
}

adslconfigins() {
	# We want all users to be able to start the adsl connection.
	insopts 655
	insinto /etc/ppp/peers
	# Save your settings in a file that can be called to start the connection in the future.
	echo "idle 0" >> options.adsl
	echo "noauth" >> options.adsl
	echo "user ${USERNAME}" >> options.adsl
	echo "usepeerdns" >> options.adsl
	echo "defaultroute" >> options.adsl
	echo "linkname mxstream" >> options.adsl
	echo pty "/usr/sbin/pptp 10.0.0.138 --nolaunchpppd --phone" "${PCNUMBER}" >> options.adsl
	newins options.adsl adsl
	pap-secretsins;
}

pap-secretsins() {
	insinto /etc/ppp
	# Save the 'secret' (password) in the secrets file.
	echo "# Secrets for authentication using PAP" >> pap-secrets
	echo "# client        server        secret        ip-addresses" >> pap-secrets
	echo "${USERNAME}      *     "'"'"${PAWD}"'"'"      *" >> pap-secrets
	doins pap-secrets
	einfo "Configuration is done!"
	einfo "If you want you can check/tweak your settings by editting /etc/ppp/pap-secrets"
	einfo "and /etc/ppp/peers/adsl. Enjoy!"
	exit;
}

# Start the configuring
a4lvarconfig;

	# Crontab Logging
	einfo "Trying to install logging..."
	local TESTER="root test -x /usr/sbin/adsl && /usr/sbin/adsl update"
	local TEST1="^/5 \* \* \* \* ${TESTER}"
	local STRING1="^/5 * * * * ${TESTER}"
	# If cron works install, else don't.
	if [ "grep -c ${TEST1} /etc/crontab" != "0" ]; then einfo "Not adding string for crontab";
	else echo -e '\n# 5-minute ADSL log update' >> /etc/crontab;
	echo -e "${STRING1}" >> /etc/crontab;
	einfo "Added to crontab: a 5 minute log update";
	fi;

	# ip-down.local logging
	local TEST=""
	local TEST2="^/usr/sbin/adsl stoplog$"
	local STRING2="/usr/sbin/adsl stoplog"
	if [ -e /etc/ppp/ip-down.local ]; then :; else touch /etc/ppp/ip-down.local; fi
	local test=`grep -c ${TEST2} /etc/ppp/ip-down.local`
	# If there already is such a string, don't do anything, else add it.
	if [ ${TEST} != "0" ]; then einfo "Not adding string for log in /etc/ppp/ip-down.local";
	else echo -e '\n# ADSL log save' >> /etc/ppp/ip-down.local;
	echo -e "${STRING2}" >> /etc/ppp/ip-down.local;
	einfo "Added to ip-down.local: log save";
	fi;
}
