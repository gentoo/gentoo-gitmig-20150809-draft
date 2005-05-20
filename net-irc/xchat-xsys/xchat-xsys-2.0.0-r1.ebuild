# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-xsys/xchat-xsys-2.0.0-r1.ebuild,v 1.1 2005/05/20 22:44:43 chainsaw Exp $

inherit eutils toolchain-funcs

MY_P="${P/xchat-/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Sysinfo plugin for X-Chat."
SRC_URI="http://mshoup.us/downloads/xsys/${MY_P}.tar.bz2"
HOMEPAGE="http://mshoup.us/downloads/xsys/README-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="bmp xmms"

DEPEND=">=net-irc/xchat-2.4.0
	bmp? ( media-plugins/bmp-infopipe )
	xmms? ( media-plugins/xmms-infopipe )"

src_unpack() {
	unpack ${A}
	sed -i -e "s:/usr/share/hwdata:/usr/share/misc:" ${S}/Makefile
	sed -i -e "s:-O2 -Wall:${CFLAGS} -Wall:" ${S}/Makefile
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "Compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe xsys-${PV}.so || die "doexe failed"

	dodoc ChangeLog README || die "dodoc failed"
}
