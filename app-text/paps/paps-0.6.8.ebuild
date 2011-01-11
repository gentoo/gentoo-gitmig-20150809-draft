# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/paps/paps-0.6.8.ebuild,v 1.1 2011/01/11 18:31:13 xmw Exp $

EAPI=3

inherit flag-o-matic

DESCRIPTION="Unicode-aware text to PostScript converter"
HOMEPAGE="http://paps.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
