# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libcompizconfig/libcompizconfig-0.6.0.ebuild,v 1.3 2007/10/24 17:39:52 lu_zero Exp $

DESCRIPTION="Compiz configuration library"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=x11-wm/compiz-0.6.0
	dev-libs/libxml2"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc TODO || "dodoc failed"
}
