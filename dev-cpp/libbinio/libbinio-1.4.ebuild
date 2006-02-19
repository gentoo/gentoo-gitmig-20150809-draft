# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libbinio/libbinio-1.4.ebuild,v 1.2 2006/02/19 18:30:12 hansmi Exp $

DESCRIPTION="Binary I/O stream class library"
HOMEPAGE="http://libbinio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
