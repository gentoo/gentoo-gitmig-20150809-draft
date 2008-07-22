# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-0.5.0_p0.ebuild,v 1.1 2008/07/22 19:43:45 loki_val Exp $

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org"
SRC_URI="http://files.libburnia-project.org/releases/${P/_p0/.pl00}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-util/pkgconfig"

S=${WORKDIR}/${P/_p0}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS CONTRIBUTORS README doc/comments
}
