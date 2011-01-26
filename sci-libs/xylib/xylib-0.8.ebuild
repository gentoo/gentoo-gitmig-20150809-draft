# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/xylib/xylib-0.8.ebuild,v 1.1 2011/01/26 17:33:09 bicatali Exp $

EAPI="3"

DESCRIPTION="Experimental x-y data reading library"
HOMEPAGE="http://www.unipress.waw.pl/fityk/xylib/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 static-libs zlib"

RDEPEND="
	dev-libs/boost
	bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with bzip2 bzlib) \
		$(use_with zlib)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO || die "dodoc failed"
}
