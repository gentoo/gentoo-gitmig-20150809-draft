# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/megapov/megapov-1.2.1.ebuild,v 1.3 2007/08/12 16:44:40 malc Exp $

inherit eutils

DESCRIPTION="The popular collection of unofficial extensions of POV-Ray"
HOMEPAGE="http://megapov.inetart.net/"
SRC_URI="http://megapov.inetart.net/packages/unix/${P}.tgz"
LICENSE="povlegal-3.6"
KEYWORDS="~amd64 ~ppc ~x86"
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
	elog "The MegaPOV files have been installed.  The following line"
	elog "has been added to the megapov/povray.ini to enable use of"
	elog "library files from the povray-3.6 installation:"
	elog
	elog "Library_Path=/usr/share/${PN}/include"
	echo
}
