# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dfbsee/dfbsee-0.7.4-r1.ebuild,v 1.3 2007/11/27 12:23:42 zzam Exp $

inherit flag-o-matic eutils

MY_PN="DFBSee"
MY_P=${MY_PN}-${PV}

DESCRIPTION="DFBSee is image viewer and video player based on DirectFB"
SRC_URI="http://www.directfb.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.directfb.org/dfbsee.xml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 -sparc x86"
IUSE=""

RDEPEND=">=dev-libs/DirectFB-0.9.24"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-direcfb-0.9.24.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	append-ldflags $(bindnow-flags)

	econf
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README AUTHORS
}
