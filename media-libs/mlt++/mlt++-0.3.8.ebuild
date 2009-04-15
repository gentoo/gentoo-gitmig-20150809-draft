# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt++/mlt++-0.3.8.ebuild,v 1.1 2009/04/15 18:37:59 aballier Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="Various bindings for mlt"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=media-libs/mlt-0.3.8"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.3.8-asneeded.patch"
	sed -i -e '/ldconfig/d' src/Makefile || die
}

src_compile() {
	emake CXX="$(tc-getCXX)" CC="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README CUSTOMISING HOWTO
}
