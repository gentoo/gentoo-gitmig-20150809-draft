# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.5-r1.ebuild,v 1.10 2005/01/01 17:59:34 eradicator Exp $

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
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ggz-client-libs-0.0.5-gcc32.diff
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog HACKING NEWS Quick* README* TODO
}
