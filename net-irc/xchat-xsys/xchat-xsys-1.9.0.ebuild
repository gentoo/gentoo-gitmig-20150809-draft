# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-xsys/xchat-xsys-1.9.0.ebuild,v 1.1 2004/12/19 16:55:37 chainsaw Exp $

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
	exeinto /usr/lib/xchat/plugins
	doexe xsys-${PV}.so

	dodoc ChangeLog README
}
