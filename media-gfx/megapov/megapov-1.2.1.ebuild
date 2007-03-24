# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/megapov/megapov-1.2.1.ebuild,v 1.1 2007/03/24 19:58:47 vanquirius Exp $

inherit eutils

DESCRIPTION="The popular collection of unofficial extensions of POV-Ray"
HOMEPAGE="http://megapov.inetart.net/"
SRC_URI="http://megapov.inetart.net/packages/unix/${P}.tgz"
LICENSE="povlegal-3.6"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

DEPEND=">=media-gfx/povray-3.6.1
	media-libs/libpng
	media-libs/tiff
	media-libs/jpeg
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-povrayconf.patch
	epatch "${FILESDIR}"/${P}-povrayini.patch
}

src_compile() {
	econf CFLAGS="${CFLAGS}" CPPFLAGS="${CXXFLAGS}" \
		--prefix="/usr" --libdir="/usr/share/${PN}" \
		--sysconfdir="/etc" --without-svga --with-x \
		COMPILED_BY="Gentoo Linux" || \
		die './configure failed'
	emake || \
		die 'compile failed'
}

src_install() {
	emake DESTDIR="${D}" install || die 'make install failed'
	ln -sf ./${P} "${D}"/usr/share/${PN}
}

pkg_postinst() {
	einfo "The MegaPOV files have been installed.  The following line"
	einfo "has been added to the megapov/povray.ini to enable use of"
	einfo "library files from the povray-3.6 installation:"
	echo
	einfo "Library_Path=/usr/share/${PN}/include"
	echo
}
