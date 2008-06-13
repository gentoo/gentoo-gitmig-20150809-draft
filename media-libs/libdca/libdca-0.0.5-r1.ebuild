# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdca/libdca-0.0.5-r1.ebuild,v 1.1 2008/06/13 22:17:59 loki_val Exp $

inherit eutils toolchain-funcs autotools base

DESCRIPTION="library for decoding DTS Coherent Acoustics streams used in DVD"
HOMEPAGE="http://www.videolan.org/developers/libdca.html"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="oss debug test"

RDEPEND="!media-libs/libdts"

DOCS="AUTHORS ChangeLog NEWS README TODO doc/${PN}.txt"

PATCHES=( "${FILESDIR}"/${P}-cflags.patch
	"${FILESDIR}"/${P}-tests-optional.patch )

src_unpack() {
	base_src_unpack
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf	$(use_enable oss) \
		$(use_enable debug) \
		$(use_enable test tests)

	emake OPT_CFLAGS="" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO doc/${PN}.txt
}
