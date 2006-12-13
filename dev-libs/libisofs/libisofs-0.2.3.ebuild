# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisofs/libisofs-0.2.3.ebuild,v 1.1 2006/12/13 00:04:39 beandog Exp $

DESCRIPTION="libisofs is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburn.pykix.org/"
SRC_URI="http://libburn-download.pykix.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/libburn-0.2.6.1"

RDEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CONTRIBUTORS README doc/comments
}
