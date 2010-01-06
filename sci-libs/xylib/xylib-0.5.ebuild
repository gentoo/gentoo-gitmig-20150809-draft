# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/xylib/xylib-0.5.ebuild,v 1.1 2010/01/06 02:59:15 bicatali Exp $

DESCRIPTION="Experimental x-y data reading library"
HOMEPAGE="http://www.unipress.waw.pl/fityk/xylib/"
SRC_URI="mirror://sourceforge/fityk/${P}.tar.bz2"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	app-arch/bzip2"
DEPEND="${RDEPEND}
	dev-libs/boost"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO || die "dodoc failed"
}
