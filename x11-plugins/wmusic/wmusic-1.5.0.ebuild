# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmusic/wmusic-1.5.0.ebuild,v 1.1 2004/07/24 10:54:28 s4t4n Exp $

DESCRIPTION="dockapp for xmms"
HOMEPAGE="http://home.jtan.com/~john/wmusic/"
SRC_URI="http://home.jtan.com/~john/wmusic/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="virtual/libc
	virtual/x11
	>media-sound/xmms-1.2.4
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}/src
	sed -i -e "s:-O2:${CFLAGS}:" Makefile.in
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin src/wmusic
	dodoc README
}
