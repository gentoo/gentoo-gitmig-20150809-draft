# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbconf/bbconf-1.10.ebuild,v 1.10 2007/09/30 15:15:28 ticho Exp $

DESCRIPTION="All-in-one blackbox configuration tool."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bbconf.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="=x11-libs/qt-3*"

src_compile () {
#	./configure --prefix=/usr --host=${CHOST} --with-qt-dir=/usr/qt/3 || die
	econf --with-qt-dir=/usr/qt/3 || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
