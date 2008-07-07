# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/oww/oww-0.82.1.ebuild,v 1.1 2008/07/07 09:06:38 bicatali Exp $

EAPI=1
DESCRIPTION="A one-wire weather station for Dallas Semiconductor"
HOMEPAGE="http://oww.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE="nls"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/gtk+:2
	net-misc/curl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:doc/oww:share/doc/${PF}/:" \
		-e '/COPYING\\/d' \
		-e '/INSTALL\\/d' \
		Makefile.in || die "Failed to fix doc install path"
}

src_compile() {
	econf \
		--enable-interactive \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
