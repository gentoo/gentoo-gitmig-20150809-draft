# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblo/liblo-0.26.ebuild,v 1.6 2011/09/12 18:38:28 ssuominen Exp $

EAPI=4

DESCRIPTION="Lightweight OSC (Open Sound Control) implementation"
HOMEPAGE="http://plugin.org.uk/liblo"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~ppc-macos"
IUSE="doc ipv6 static-libs"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

RESTRICT="test"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	use doc || export ac_cv_prog_HAVE_DOXYGEN="false"

	econf \
		$(use_enable static-libs static) \
		$(use_enable ipv6)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
