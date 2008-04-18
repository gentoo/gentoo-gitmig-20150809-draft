# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/xylib/xylib-0.2.ebuild,v 1.1 2008/04/18 08:50:58 bicatali Exp $

DESCRIPTION="Experimental x-y data reading library"
HOMEPAGE="http://www.unipress.waw.pl/fityk/xylib/"
SRC_URI="mirror://sourceforge/fityk/${P}.tar.bz2"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/boost"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO || die "dodoc failed"
}
