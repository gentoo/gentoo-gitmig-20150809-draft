# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/electric/electric-6.08-r1.ebuild,v 1.4 2005/07/25 17:41:51 caleb Exp $

inherit eutils qt3

IUSE="qt"

DESCRIPTION="Electric is a sophisticated electrical CAD system that can  handle many forms of circuit design"
HOMEPAGE="http://www.gnu.org/software/electric/electric.html"
SRC_URI="http://ftp.gnu.org/pub/gnu/electric/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

DEPEND="virtual/libc
	!qt? ( virtual/motif )
	qt? ( $(qt_min_version 3.1) )"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${PV}-fix-sandbox-r1.patch
	use qt && epatch ${FILESDIR}/${PV}-qt.patch
}

src_compile() {
	econf || die "./configure failed"
	sed -e 's:/usr/local/:/usr/:g' -i src/include/config.h
	emake || die
}

src_install() {
	einstall DESTDIR="${D}"

	dodoc ChangeLog COPYING README
}
