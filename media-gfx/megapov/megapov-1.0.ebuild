# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/megapov/megapov-1.0.ebuild,v 1.1 2003/07/30 08:12:51 msterret Exp $

DESCRIPTION="The popular collection of unofficial extensions of POV-Ray"
HOMEPAGE="http://megapov.inetart.net/"
SRC_URI="http://megapov.inetart.net/${P}_unix_s.tgz"
LICENSE="povlegal-3.5"
KEYWORDS="~x86"
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
	einfo "The MegaPOV files have been installed.  You will have to"
	einfo "adjust your main POV-Ray ini file by adding a new line:"
	echo
	einfo "Library_Path=/usr/share/${PN}/include"
	echo
	einfo "This ini file is possibly located at:"
	echo
	einfo "  - the place defined by the POVINI environment variable"
	einfo "  - ./povray.ini"
	einfo "  - \$HOME/.povrayrc"
	einfo "  - SYSCONFDIR/povray.ini"
}
