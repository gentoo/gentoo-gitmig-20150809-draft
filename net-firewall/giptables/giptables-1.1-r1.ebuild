# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/giptables/giptables-1.1-r1.ebuild,v 1.1 2005/01/16 08:37:01 dragonheart Exp $

DESCRIPTION="set of shell scripts that help generate iptables rules"
HOMEPAGE="http://www.giptables.org/"
SRC_URI="http://www.giptables.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="net-firewall/iptables"

src_install() {
	dodir /etc/{conf.d,init.d}

	# Creating GIPTables home, modules and conf directories
	dodir /lib/giptables /lib/giptables/modules /lib/giptables/conf
	chmod -R 700 ${D}/lib/giptables

	# Copying GIPTables main library file /lib/giptables/giptables-main
	cp -f ${S}/giptables-main ${D}/lib/giptables

	# Copying GIPTables module files /lib/giptables/modules/*
	cp -f ${S}/modules/* ${D}/lib/giptables/modules
	# Copying fixed GIPTables NTP module file to /lib/giptables/modules/
	cp -f ${FILESDIR}/giptables-NTP ${D}/lib/giptables/modules
	chmod 600 ${D}/lib/giptables/modules/*

	# Copying GIPTables example configuration files /lib/giptables/conf/*
	cp -f ${S}/conf/* ${D}/lib/giptables/conf
	chmod 600 ${D}/lib/giptables/conf/*

	# Copying other GIPTables files
	cp ${S}/if_ipaddr ${D}/lib/giptables
	chmod 700 ${D}/lib/giptables/if_ipaddr

	cp ${S}/rc.giptables.blocked ${D}/etc/conf.d/giptables.blocked
	cp ${S}/rc.giptables.custom ${D}/etc/conf.d/giptables.custom
	chmod 600 ${D}/etc/conf.d/giptables.blocked ${D}/etc/conf.d/giptables.custom

	# Creating docs
	dodoc AUTHORS COPYING ChangeLog* INSTALL README TODO
	dodir /usr/share/doc/${PF}/html
	mv ${S}/documentation/* ${D}/usr/share/doc/${PF}/html

	# Creating init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/giptables.init giptables
}

pkg_preinst() {
	for conf_file in ${D}/lib/giptables/conf/*
	do
	    sed -e 's/rc\.d\/rc\.giptables\.custom/conf\.d\/giptables\.custom/g' -e 's/rc\.d\/rc\.giptables\.blocked/conf\.d\/giptables\.blocked/g' $conf_file > $conf_file.orig
	    mv --force $conf_file.orig $conf_file
	done
}

pkg_postinst() {
	einfo
	einfo "Before running /etc/init.d/giptables or adding it to a runlevel with"
	einfo "rc-update, be sure to create a config file /etc/giptables.conf"
	einfo
	einfo "For sample config files, please, look at /lib/giptables/conf"
	einfo
}
