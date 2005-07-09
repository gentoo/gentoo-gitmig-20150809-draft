# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wavemon/wavemon-0.4.0b.ebuild,v 1.10 2005/07/09 03:55:40 halcy0n Exp $

inherit eutils

DESCRIPTION="ncurses based monitor util for your wavelan cards"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.janmorgenstern.de/projects-software.html"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~amd64"

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/wavemon-gcc-fixes.patch
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
