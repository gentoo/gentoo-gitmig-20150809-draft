# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtella/qtella-0.3.0.ebuild,v 1.1 2001/11/18 23:03:00 verwilst Exp $

S=${WORKDIR}/${P}

SRC_URI="http://prdownloads.sourceforge.net/qtella/${P}.tar.gz"

HOMEPAGE="http://qtella.sourceforge.net"
DESCRIPTION="QTella 0.3.0 (KDE Gnutella Client)"

DEPEND="virtual/glibc
	>=x11-libs/qt-x11-2.2
	>=kde-base/kdelibs-2.2"

src_compile() {

	./configure --host=${CHOST} --prefix=/usr|| die
	make || die "Make sure QT is built with 'qtmt' set in USE, QTella will not compile otherwise"

}

src_install() {
	
	make prefix=${D}/usr install ¦¦ die

}


