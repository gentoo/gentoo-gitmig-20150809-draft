# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-xsys/xchat-xsys-2.0.6-r1.ebuild,v 1.1 2005/06/20 18:49:00 chainsaw Exp $

inherit toolchain-funcs eutils

MY_P="${P/xchat-/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Sysinfo plugin for X-Chat."
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://dev.gentoo.org/~chainsaw/xsys/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="bmp xmms buttons"

DEPEND=">=net-irc/xchat-2.4.0
	sys-apps/pciutils
	bmp? ( media-plugins/bmp-infopipe )
	xmms? ( media-plugins/xmms-infopipe )"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2 -Wall:${CFLAGS} -Wall:" ${S}/Makefile
	if use buttons; then
		sed -i -e "s:#BUTTON:BUTTON:" ${S}/Makefile
	fi
	epatch ${FILESDIR}/${PV}-localisation.patch
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "Compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe xsys-${PV}.so || die "doexe failed"

	dodoc ChangeLog README || die "dodoc failed"
}
