# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gmm/gmm-3.1.ebuild,v 1.5 2009/11/30 06:09:44 josejx Exp $

inherit eutils

DESCRIPTION="Generic C++ template library for sparse, dense and skyline matrices"
SRC_URI="http://download.gna.org/getfem/stable/${P}.tar.gz"
HOMEPAGE="http://www-gmm.insa-toulouse.fr/getfem/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS
}
