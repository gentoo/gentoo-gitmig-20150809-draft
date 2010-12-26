# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpipeline/libpipeline-1.1.0.ebuild,v 1.1 2010/12/26 18:44:40 ssuominen Exp $

EAPI=2

DESCRIPTION="A pipeline manipulation library"
HOMEPAGE="http://libpipeline.nongnu.org/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( dev-libs/check )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
