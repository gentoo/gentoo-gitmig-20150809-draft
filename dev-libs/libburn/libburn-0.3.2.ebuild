# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-0.3.2.ebuild,v 1.1 2007/02/13 00:29:55 metalgod Exp $

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia.pykix.org/"
SRC_URI="http://libburnia-download.pykix.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc"

RDEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CONTRIBUTORS README ChangeLog NEWS doc/comments
}
