# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gf2x/gf2x-0.9.5.ebuild,v 1.1 2009/08/10 22:46:32 bicatali Exp $

EAPI=2

PID=22129 # hack

DESCRIPTION="C/C++ routines for fast arithmetic in GF(2)[x]"
HOMEPAGE="http://gf2x.gforge.inria.fr/"
SRC_URI="http://gforge.inria.fr/frs/download.php/${PID}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="sse2"
DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable sse2) ABI=default
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README AUTHORS BUGS
}
