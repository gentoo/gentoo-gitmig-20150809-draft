# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.5-r1.ebuild,v 1.7 2004/04/19 12:13:57 wolf31o2 Exp $

inherit eutils

DESCRIPTION="The client libraries for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

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
