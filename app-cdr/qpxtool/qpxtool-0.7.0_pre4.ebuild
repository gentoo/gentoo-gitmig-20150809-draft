# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/qpxtool/qpxtool-0.7.0_pre4.ebuild,v 1.1 2009/09/28 11:14:16 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="CD/DVD quality checking utilities"
HOMEPAGE="http://qpxtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	media-libs/libpng"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/_}

src_prepare() {
	sed -i -e 's:/usr/local:/usr:g' configure \
		lib/qpxscan/include/qpx_scan.h || die
}

src_configure() {
	./configure CXX="$(tc-getCXX)" || die
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README ReleaseNotes TODO
	dohtml status.html
}
