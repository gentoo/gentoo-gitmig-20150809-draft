# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-xsys/xchat-xsys-2.0.8-r1.ebuild,v 1.8 2006/02/19 18:40:09 chainsaw Exp $

inherit toolchain-funcs eutils

MY_P="${P/xchat-/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Sysinfo plugin for X-Chat."
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://dev.gentoo.org/~chainsaw/xsys/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="xmms buttons"

DEPEND="|| (
		>=net-irc/xchat-2.4.0
		>=net-irc/xchat-gnome-0.4
	)
	sys-apps/pciutils
	xmms? ( media-sound/xmms )"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2 -Wall:${CFLAGS} -Wall:" ${S}/Makefile
	if use buttons; then
		sed -i -e "s:#BUTTON:BUTTON:" ${S}/Makefile
	fi
	if use xmms; then
		sed -i -e "s:# FOR XMMS # ::g" ${S}/Makefile
	fi
	epatch ${FILESDIR}/${PV}-pciutils-headerchange.patch
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "Compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe xsys-${PV}.so || die "doexe failed"

	dodoc ChangeLog README || die "dodoc failed"
}
