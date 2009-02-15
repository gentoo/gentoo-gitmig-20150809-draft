# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbconf/bbconf-1.10.ebuild,v 1.11 2009/02/15 00:50:29 loki_val Exp $

inherit eutils

DESCRIPTION="All-in-one blackbox configuration tool."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bbconf.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="=x11-libs/qt-3*"

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile () {
#	./configure --prefix=/usr --host=${CHOST} --with-qt-dir=/usr/qt/3 || die
	econf --with-qt-dir=/usr/qt/3 || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
}
