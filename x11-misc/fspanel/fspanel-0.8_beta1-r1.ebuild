# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fspanel/fspanel-0.8_beta1-r1.ebuild,v 1.1 2002/12/11 02:57:12 mkeadle Exp $

S=${WORKDIR}/fspanel-0.8beta1
DESCRIPTION="F***ing Small Panel. Good (and small) replacement for gnome-panel"
SRC_URI="http://www.chatjunkies.org/fspanel/fspanel-0.8beta1.tar.gz"
HOMEPAGE="http://www.chatjunkies.org/fspanel"

SLOT="0"
KEYWORDS="x86 sparc"
LICENSE="GPL-2"

DEPEND="virtual/x11"

src_compile() {

	if pkg-config xft
	then
		CFLAGS="${CFLAGS} -I/usr/include/freetype2"
	fi
	./configure
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe ${S}/fspanel

	dodoc README
}
