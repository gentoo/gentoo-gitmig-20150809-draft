# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-xsys/xchat-xsys-1.0.6.ebuild,v 1.1 2004/10/30 22:21:17 chainsaw Exp $

inherit flag-o-matic

MY_P=${P/xchat-/}
DESCRIPTION="Sysinfo plugin for X-Chat."
SRC_URI="http://dev.gentoo.org/~chainsaw/xsys/download/${MY_P}.tar.bz2 mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://dev.gentoo.org/~chainsaw/xsys/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="bmp uptimed"
S=${WORKDIR}/${MY_P}

DEPEND=">=dev-libs/glib-2.0.3
	>=net-irc/xchat-2.4.0
	bmp? ( media-sound/beep-media-player )
	uptimed? ( app-misc/uptimed )"

src_compile() {
	if use uptimed; then
		append-flags -DUSE_UPRECORD
	fi
	if use bmp; then
		append-flags -DUSE_BMP -I/usr/include/beep-media-player
		append-ldflags -lbeep
	fi
	emake -j1 || die "Compile failed"
}

src_install() {
	exeinto /usr/lib/xchat/plugins
	doexe libxsys-${PV}.so

	dodoc ChangeLog README
}
