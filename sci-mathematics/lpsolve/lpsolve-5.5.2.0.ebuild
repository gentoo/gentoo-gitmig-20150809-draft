# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/lpsolve/lpsolve-5.5.2.0.ebuild,v 1.3 2011/10/26 15:42:05 chainsaw Exp $

EAPI=4

DESCRIPTION="Mixed Integer Linear Programming (MILP) solver"
HOMEPAGE="http://sourceforge.net/projects/lpsolve/"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

DEPEND="sci-libs/colamd"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}

src_install() {
	default
	# required because it does not provide .pc file
	use static-libs || find "${ED}" -name '*.la' -exec rm -f {} +
}
