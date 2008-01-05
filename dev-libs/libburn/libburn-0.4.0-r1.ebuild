# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-0.4.0-r1.ebuild,v 1.1 2008/01/05 17:14:28 drac Exp $

inherit multilib

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia.pykix.org/"
SRC_URI="http://libburnia-download.pykix.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="virtual/libc"

RDEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CONTRIBUTORS README ChangeLog NEWS doc/comments
	dosym libburn-5.pc /usr/$(get_libdir)/pkgconfig/libburn-1.pc
}
