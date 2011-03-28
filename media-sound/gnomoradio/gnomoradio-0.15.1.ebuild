# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomoradio/gnomoradio-0.15.1.ebuild,v 1.12 2011/03/28 18:24:27 angelos Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Finds, fetches, shares, and plays freely licensed music."
HOMEPAGE="http://gnomoradio.org"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="vorbis"

RDEPEND="dev-cpp/gtkmm:2.4
	dev-cpp/glibmm:2
	>=dev-cpp/gconfmm-2.6
	dev-cpp/libxmlpp:2.6
	dev-libs/libsigc++:2
	media-libs/libao
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc42.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-lm.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable vorbis)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
