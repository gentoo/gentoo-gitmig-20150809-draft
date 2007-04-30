# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/megapov/megapov-1.0.ebuild,v 1.4 2007/04/30 22:39:19 genone Exp $

DESCRIPTION="The popular collection of unofficial extensions of POV-Ray"
HOMEPAGE="http://megapov.inetart.net/"
SRC_URI="http://megapov.inetart.net/${P}_unix_s.tgz"
LICENSE="povlegal-3.5"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

DEPEND=">=media-gfx/povray-3.5
	media-libs/libpng
	media-libs/tiff
	media-libs/jpeg
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd ${S}

	# since svgalib seems to be dying off I choose to remove support for it
	# from the Makefile so megapov doesn't DEPEND on it.  Someone else is
	# welcome to add proper USE support for it if they want.
	sed -i \
		-e '/HAVE_LIBVGA/ s/HAVE/DONT_HAVE/' \
		-e 's/-lvgagl -lvga//' \
		-e '/^LIBS_DISP/ s/$/ -lpthread/' unix/Makefile || \
			die 'sed src/Makefile failed'
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CPPFLAGS="${CXXFLAGS}" \
		prefix="/usr" libdir="/usr/share/${PN}" \
		docdir="/usr/share/doc/${P}" sysconfdir="/etc"
}

src_install() {
	local LIBDIR="/usr/share/${PN}/"
	local DOCDIR="/usr/share/doc/${P}/html/"

	mkdir -p ${D}${LIBDIR}
	mkdir -p ${D}${DOCDIR}

	into /usr
	dobin ./build_unix/megapov
	cp -R ./scenes ./include ${D}$LIBDIR
	cp -R ./manual/* ${D}$DOCDIR
	dodoc README
}

pkg_postinst() {
	elog "The MegaPOV files have been installed.  You will have to"
	elog "adjust your main POV-Ray ini file by adding a new line:"
	elog
	elog "Library_Path=/usr/share/${PN}/include"
	elog
	elog "This ini file is possibly located at:"
	elog
	elog "  - the place defined by the POVINI environment variable"
	elog "  - ./povray.ini"
	elog "  - \$HOME/.povrayrc"
	elog "  - SYSCONFDIR/povray.ini"
}
