# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/multimux/multimux-0.2.4.ebuild,v 1.1 2005/10/31 22:29:34 matsuu Exp $

IUSE=""

DESCRIPTION="combines up to 8 audio mono wave ch. into one big multi ch. wave file."
HOMEPAGE="http://panteltje.com/panteltje/dvd/"
SRC_URI="http://panteltje.com/panteltje/dvd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/^CFLAGS/s/-O2/${CFLAGS}/" Makefile || die
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin multimux
	dodoc CHANGES LICENSE README
}
