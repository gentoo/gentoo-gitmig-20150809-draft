# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/browser-config/browser-config-1.1.ebuild,v 1.2 2003/04/13 12:47:43 vladimir Exp $

DESCRIPTION="A lightweight modular configurable http url handler/browser launcher"
HOMEPAGE="http://www.pocketninja.com/"
SRC_URI="http://www.pocketninja.com/code/browser-config/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
DEPEND=""

src_install() {
	into /usr
	dobin browser-config
	dosym /usr/bin/browser-config /usr/bin/runbrowser
	insinto /usr/share/browser-config
	doins definitions/*
}

pkg_postinst() {
	echo
	einfo "Please run browser-config -b <browser> -m <method>"
	einfo "If run as root, it will be global, if run as a user it will be for"
	einfo "  that user only."
	echo
	einfo "Please see browser-config -h for info on available browsers/methods"
	echo
	einfo "You may then tell your applications to use either 'runbrowser' or"
	einfo "  'browser-config' as a browser."
	echo
}
