# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpipeline/libpipeline-1.2.0.ebuild,v 1.5 2011/06/23 20:08:01 ranger Exp $

EAPI="2"

DESCRIPTION="a pipeline manipulation library"
HOMEPAGE="http://libpipeline.nongnu.org/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~x86"
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

	use static-libs || find "${D}" -name '*.la' -exec rm -f '{}' +
}
