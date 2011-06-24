# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpano13/libpano13-2.9.17.ebuild,v 1.6 2011/06/24 16:40:44 ranger Exp $

EAPI="2"

inherit eutils versionator java-pkg-opt-2

DESCRIPTION="Helmut Dersch's panorama toolbox library"
HOMEPAGE="http://panotools.sourceforge.net/"
SRC_URI="mirror://sourceforge/panotools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="java static-libs"

DEPEND="media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	virtual/jpeg
	java? ( >=virtual/jdk-1.3 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng-1.5.patch
}

src_configure() {
	econf \
		$(use_with java java ${JAVA_HOME}) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README README.linux AUTHORS NEWS doc/*.txt

	if ! use static-libs ; then
		find "${D}" -name '*.la' -delete || die
	fi
}

pkg_postinst() {
	ewarn "you should remerge all reverse dependencies (media-gfx/hugin and"
	ewarn "media-gfx/autopano-sift-C) as they might not work anymore"
}
