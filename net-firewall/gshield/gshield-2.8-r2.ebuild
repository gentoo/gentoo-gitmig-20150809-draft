# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/gshield/gshield-2.8-r2.ebuild,v 1.6 2005/08/23 18:14:56 flameeyes Exp $

# re-capitalize gShield
S=${WORKDIR}/gShield-${PV}

DESCRIPTION="iptables firewall configuration system"
HOMEPAGE="http://muse.linuxmafia.org/gshield.html"
SRC_URI="ftp://muse.linuxmafia.org/pub/gShield/v2/gShield-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND="net-firewall/iptables
	net-dns/bind-tools"

src_install() {
	# config files
	dodir /etc/gshield
	cp -pPR * ${D}/etc/gshield
	ln -s gshield ${D}/etc/firewall

	# get rid of docs from config
	rm -rf ${D}/etc/gshield/{Changelog,INSTALL,LICENSE,docs}

	# move non-config stuff out of config, but make symlinks
	dodir /usr/share/gshield/routables
	for q in gShield-version gShield.rc tools sourced routables/routable.rules
	do
		mv ${D}/etc/gshield/$q ${D}/usr/share/gshield/
		ln -s /usr/share/gshield/$q ${D}/etc/gshield/$q
	done
	chmod -R u+rwX ${D}/etc/gshield

	# install init script
	dodir /etc/init.d
	cp ${FILESDIR}/gshield.init ${D}/etc/init.d/gshield
	chmod -R u+rwx ${D}/etc/init.d/gshield

	# docs
	dodoc Changelog INSTALL LICENSE docs/*
}

pkg_postinst() {
	einfo
	einfo "Before running /etc/init.d/gshield or adding it to a runlevel with"
	einfo "rc-update, be sure to edit the firewall config file so that it will"
	einfo "work for your site:"
	einfo "  ${EDITOR} /etc/gshield/gShield.conf"
	einfo
}
