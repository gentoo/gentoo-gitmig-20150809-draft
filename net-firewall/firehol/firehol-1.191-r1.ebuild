# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firehol/firehol-1.191-r1.ebuild,v 1.1 2004/08/01 21:30:32 centic Exp $

inherit eutils

DESCRIPTION="iptables firewall generator"
HOMEPAGE="http://firehol.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

RDEPEND="net-firewall/iptables
	sys-apps/iproute2"

# patch for problems with bash-3.0, can be removed in next version of firehol as
# this is a backport from firehol-CVS.
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-bash-3.0.patch
}

src_install() {
	newsbin firehol.sh firehol
	dodir /etc/firehol /etc/firehol/examples
	insinto /etc/firehol/examples
	doins examples/*
	dodoc ChangeLog COPYING README TODO WhatIsNew
	dohtml doc/*.html doc/*.css
	docinto scripts
	dodoc get-iana.sh adblock.sh
	doman man/*.1 man/*.5
	exeinto /etc/init.d
	newexe ${FILESDIR}/firehol.initrd firehol
}

pkg_postinst() {
	einfo "The default path to firehol's configuration file is /etc/firehol/firehol.conf"
	einfo "See /etc/firehol/examples for configuration examples."
	#
	# Install a default configuration if none is available yet
	if [[ ! -e "${ROOT}/etc/firehol/firehol.conf" ]]; then
		einfo "Installing a sample configuration as ${ROOT}/etc/firehol/firehol.conf"
		cp "${ROOT}/etc/firehol/examples/client-all.conf" "${ROOT}/etc/firehol/firehol.conf"
	fi
}

