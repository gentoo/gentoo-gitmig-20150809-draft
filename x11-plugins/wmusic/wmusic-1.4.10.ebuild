# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmusic/wmusic-1.4.10.ebuild,v 1.5 2004/01/04 18:36:48 aliz Exp $

DESCRIPTION="dockapp for xmms"
HOMEPAGE="http://home.jtan.com/~john/wmusic/"
SRC_URI="http://home.jtan.com/~john/wmusic/downloads/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""
DEPEND="virtual/glibc
	virtual/x11
	>media-sound/xmms-1.2.4"

S=${WORKDIR}/${P}

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
