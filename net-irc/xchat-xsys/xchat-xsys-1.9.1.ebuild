# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-xsys/xchat-xsys-1.9.1.ebuild,v 1.2 2004/12/27 02:58:33 eradicator Exp $

inherit flag-o-matic eutils

MY_P=${P/xchat-/}
DESCRIPTION="Sysinfo plugin for X-Chat."
SRC_URI="http://mshoup.us/downloads/xsys/${MY_P}.tar.bz2"
HOMEPAGE="http://mshoup.us/downloads/xsys/README-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND=">=net-irc/xchat-2.4.0"

src_compile() {
	emake -j1 || die "Compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe xsys-${PV}.so

	dodoc ChangeLog README
}
