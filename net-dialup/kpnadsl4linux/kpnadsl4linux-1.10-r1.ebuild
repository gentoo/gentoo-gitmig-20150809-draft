# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kpnadsl4linux/kpnadsl4linux-1.10-r1.ebuild,v 1.3 2002/12/28 14:48:38 pvdabeel Exp $

IUSE=""
DESCRIPTION="ADSL4Linux, a PPTP start/stop/etc. program especially for Dutch users, for gentoo."
HOMEPAGE="http://www.adsl4linux.nl/"
SRC_URI="http://home.planet.nl/~mcdon001/${P}.tar.gz
	http://www.adsl4linux.nl/download/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
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
	einfo "Do _NOT_ forget to run the following if this is your _FIRST_ install:"
	einfo "ebuild /var/db/pkg/${CATEGORY}/${P}-${PR}/${P}-${PR}.ebuild config"
	einfo "To start ${P} at boot type:"
	einfo "rc-update add adsl default"
}

pkg_config() {

a4lvarconfig() {
	# Get username, password and 'phonenumber' (pc1/pc2/pc3/...)
	echo "What's your username? (ie. myname@subscription-form)"; read USERNAME;
	echo ""
	echo "What's your password?"; read PAWD;
	echo ""
	echo "If you have a subscription with multiple ip addresses, please specify your 'pc-number'? (ie. pc3) Press"\
	"ENTER if you have no idea what I'm talking about."; read PCNUMBER;
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
	if [ -d /etc/ppp/peers ]; then :; else mkdir /etc/ppp/peers; fi
	cd /etc/ppp/peers

	# Save your settings to a file.
	echo "idle 0" > .adsl
	echo "noauth" >> .adsl
	echo "user ${USERNAME}" >> .adsl
	echo "usepeerdns" >> .adsl
	echo "defaultroute" >> .adsl
	echo "linkname mxstream" >> .adsl
	echo 'pty "/usr/sbin/pptp 10.0.0.138 --nolaunchpppd --phone '"${PCNUMBER}"'"' >> .adsl
	if [ -e adsl ]; then mv .adsl ._cfg0000_adsl; else mv .adsl adsl; fi
	chmod 644 adsl
	pap-secretsins;
}

pap-secretsins() {
	if [ -d /etc/ppp/peers ]; then :; else mkdir /etc/ppp/peers; fi
	cd /etc/ppp
	# Save the 'secret' (password) in the secrets file.
	echo "# Secrets for authentication using PAP" > .pap-secrets
	echo "# client        server        secret        ip-addresses" >> .pap-secrets
	echo "${USERNAME}      *     "'"'"${PAWD}"'"'"      *" >> .pap-secrets
	if [ -e pap-secrets ]; then mv .pap-secrets ._cfg0000_pap-secrets; else mv .pap-secrets pap-secrets; fi
	loggingadsl;
}

loggingadsl() {
	# Crontab Logging
	echo "Trying to install logging..."
	local TESTER="root test -x /usr/sbin/adsl && /usr/sbin/adsl update"
	local STRING1="/5 * * * * ${TESTER}"
	# Check if /etc/crontab exists
	if [ -e /etc/crontab ]; then \
	# If cron works install, else don't.
	if [ `grep -c "/5 \* \* \* \* ${TESTER}" /etc/crontab` != "0" ]; then echo "Not adding string for crontab";
	else echo -e '\n# 5-minute ADSL log update' >> /etc/crontab;
	echo -e "${STRING1}" >> /etc/crontab;
	echo "Added to crontab: a 5 minute log update";
	fi;
	else echo "/etc/crontab doesn't exist!"
	fi;

	# ip-down.local logging
	local TEST=""
	local TEST2="^/usr/sbin/adsl stoplog$"
	local STRING2="/usr/sbin/adsl stoplog"
	if [ -e /etc/ppp/ip-down.local ]; then :; else touch /etc/ppp/ip-down.local; fi
	local test=`grep -c "${TEST2}" /etc/ppp/ip-down.local`
	# If there already is such a string, don't do anything, else add it.
	if [ "${TEST}" != "0" ]; then echo "Not adding string for log in /etc/ppp/ip-down.local";
	else echo -e '\n# ADSL log save' >> /etc/ppp/ip-down.local;
	echo -e "${STRING2}" >> /etc/ppp/ip-down.local;
	echo "Added to ip-down.local: log save";
	fi;

	echo "Configuration is done!"
	echo "If you want you can check/tweak your settings by editting /etc/ppp/pap-secrets"
	echo "and /etc/ppp/peers/adsl. Enjoy!"
	echo -e "\e[33;01m* IMPORTANT:\e[00;00m files in /etc _MAY_ need updating.";
	echo -e "\e[33;01m*\e[00;00m Type \e[32;01memerge --help config \e[00;00mto learn how to update config files.";

	exit;
}

# Start the configuring
a4lvarconfig;

}
