# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/giptables/giptables-1.1.ebuild,v 1.5 2004/03/20 07:34:37 mr_bones_ Exp $

DESCRIPTION="set of shell scripts that help generate iptables rules"
HOMEPAGE="http://www.giptables.org/"
SRC_URI="http://www.giptables.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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
	    sed -f ${FILESDIR}/replace.sed $conf_file > ${D}/lib/giptables/conf/sed.tmp
	    mv ${D}/lib/giptables/conf/sed.tmp $conf_file
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
