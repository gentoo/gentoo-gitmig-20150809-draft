# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.5-r1.ebuild,v 1.3 2003/08/20 05:08:05 vapier Exp $

inherit eutils

DESCRIPTION="The client libraries for GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND=">=dev-games/libggz-0.0.5
	dev-libs/expat"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/ggz-client-libs-0.0.5-gcc32.diff
}

src_compile() {
 	econf || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog HACKING NEWS Quick* README* TODO
}
