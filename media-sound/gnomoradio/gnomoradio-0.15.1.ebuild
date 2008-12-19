# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomoradio/gnomoradio-0.15.1.ebuild,v 1.10 2008/12/19 18:04:30 aballier Exp $

EAPI=1

inherit eutils

DESCRIPTION="Finds, fetches, shares, and plays freely licensed music."
HOMEPAGE="http://gnomoradio.org"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="vorbis"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/glibmm-2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libxmlpp-2.6
	dev-libs/libsigc++:2
	media-libs/libao
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc42.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf --disable-dependency-tracking $(use_enable vorbis)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
