# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/browser-config/browser-config-1.0.ebuild,v 1.1 2004/08/15 09:40:44 stuart Exp $

DESCRIPTION="A lightweight modular configurable http url handler/browser launcher"
HOMEPAGE="http://www.pocketninja.com/"
SRC_URI="http://www.pocketninja.com/code/browser-config/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
DEPEND=""

src_install() {
	into /usr
	dobin browser-config
	dosym /usr/bin/browser-config /usr/bin/runbrowser
	insinto /usr/share/browser-config
	doins definitions/*
}
