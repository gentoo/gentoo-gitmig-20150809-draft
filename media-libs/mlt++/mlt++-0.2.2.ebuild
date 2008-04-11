# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt++/mlt++-0.2.2.ebuild,v 1.3 2008/04/11 01:31:43 mr_bones_ Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Various bindings for mlt"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=media-libs/mlt-0.2.2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-20060601-as-needed.patch"
	epatch "${FILESDIR}/${PN}-20060601-relink.patch"
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
}

src_compile() {
	tc-export CXX
	econf
	emake CC="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc README CUSTOMISING HOWTO
}
