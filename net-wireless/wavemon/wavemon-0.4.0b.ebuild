# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wavemon/wavemon-0.4.0b.ebuild,v 1.3 2003/07/24 17:01:23 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ncurses based monitor util for your wavelan cards"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.jm-music.de/projects.html"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/wavemon_gcc33_fix
	cd ${S}

	mv configure configure.orig
	sed -e "s|^CFLAGS=\".*\"|CFLAGS=\"${CFLAGS}\"|" \
		configure.orig > configure
	chmod +x configure
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/{man1,man5}
	make prefix="${D}/usr" mandir="${D}/usr/share/man" install
	dodoc README TODO COPYING AUTHORS
}
