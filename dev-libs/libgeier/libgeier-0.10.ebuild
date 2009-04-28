# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgeier/libgeier-0.10.ebuild,v 1.2 2009/04/28 19:29:33 hanno Exp $

DESCRIPTION="Libgeier provides a library to access the german digital tax project ELSTER."
HOMEPAGE="http://www.taxbird.de/"
SRC_URI="http://www.taxbird.de/download/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/xmlsec
	dev-libs/nspr
	dev-libs/nss
	sys-libs/zlib"

DEPEND="${RDEPEND}
	dev-lang/swig"

src_compile() {
	econf || die "Configure failed!"
	emake || die "Make failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed!"
	find "${D}" -name '*.la' -delete
	dodoc README || die "dodoc failed"
}
