# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgig/libgig-3.1.1.ebuild,v 1.1 2007/08/19 18:19:15 drac Exp $

inherit eutils

DESCRIPTION="a C++ library for loading Gigasampler files and DLS (Downloadable Sounds) Level 1/2 files."
HOMEPAGE="http://stud.fh-heilbronn.de/~cschoene/projects/libgig"
SRC_URI="http://stud.fh-heilbronn.de/~cschoene/projects/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=media-libs/libsndfile-1.0.2
	>=media-libs/audiofile-0.2.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {
	econf
	emake -j1 || die "emake failed."

	if use doc; then
		emake -j1 docs || die "emake docs failed."
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use doc; then
		mv "${S}"/doc/html "${D}"/usr/share/doc/${PF}/
	fi
}
