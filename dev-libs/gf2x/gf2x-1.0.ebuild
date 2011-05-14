# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gf2x/gf2x-1.0.ebuild,v 1.1 2011/05/14 09:56:27 tomka Exp $

EAPI=2

PID=27999 # hack

DESCRIPTION="C/C++ routines for fast arithmetic in GF(2)[x]"
HOMEPAGE="http://gf2x.gforge.inria.fr/"
SRC_URI="http://gforge.inria.fr/frs/download.php/${PID}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

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
