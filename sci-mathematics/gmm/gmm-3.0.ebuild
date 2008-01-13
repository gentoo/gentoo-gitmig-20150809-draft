# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gmm/gmm-3.0.ebuild,v 1.1 2008/01/13 20:13:10 philantrop Exp $

inherit eutils

DESCRIPTION="GMM++ is a generic C++ template library for sparse, dense and skyline matrices."
SRC_URI="http://download.gna.org/getfem/stable/${P}.tar.gz"
HOMEPAGE="http://www-gmm.insa-toulouse.fr/getfem/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS INSTALL README NEWS
}
