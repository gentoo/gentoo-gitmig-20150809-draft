# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt++/mlt++-0.3.0.ebuild,v 1.1 2008/09/21 11:45:22 aballier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Various bindings for mlt"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=media-libs/mlt-0.3.0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-20060601-as-needed.patch"
	epatch "${FILESDIR}/${PN}-20060601-relink.patch"
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
