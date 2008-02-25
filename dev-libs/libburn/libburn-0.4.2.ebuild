# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-0.4.2.ebuild,v 1.1 2008/02/25 01:36:50 beandog Exp $

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org/"
SRC_URI="http://files.libburnia-project.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-util/pkgconfig-0.12"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CONTRIBUTORS README ChangeLog NEWS doc/comments
}
