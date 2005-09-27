# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/urt/urt-3.1b.ebuild,v 1.3 2005/09/27 12:05:32 seemant Exp $

inherit eutils

DESCRIPTION="the Utah Raster Toolkit is a library for dealing with raster images"
HOMEPAGE="http://www.cs.utah.edu/gdc/projects/urt/"
SRC_URI="ftp://ftp.iastate.edu/pub/utah-raster/${P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gif gs tiff X"

DEPEND="X? ( virtual/x11 )
	gif? ( media-libs/giflib )
	tiff? ( media-libs/tiff )
	gs? ( app-text/ghostscript )"

S=${WORKDIR}

urt_config() {
	use $1 && echo "#define $2" || echo "##define $2"
}

src_unpack() {
	unpack ${A} ; cd "${S}"
	chmod +w bin/README
	rm -f bin/README

	epatch "${FILESDIR}"/${P}-rle-fixes.patch
	epatch "${FILESDIR}"/${P}-compile-updates.patch
	epatch "${FILESDIR}"/${P}-tempfile.patch

	sed -i -e '/^CFLAGS/s: -O : :' makefile.hdr
	cp "${FILESDIR}"/gentoo-config config/gentoo
	cat >> config/gentoo <<-EOF
	$(urt_config X X11)
	$(urt_config gif GIF)
	$(urt_config gs POSTSCRIPT)
	$(urt_config tiff TIFF)
	ExtraCFLAGS = ${CFLAGS}
	MFLAGS = ${MAKEOPTS}
	EOF
}

src_compile() {
	./Configure config/gentoo || die "config"
	emake || die "emake"
}

src_install() {
	# this just installs it into some local dirs
	make install || die
	dobin bin/* || die "dobin"
	dolib.a lib/librle.a || die "dolib.a"
	insinto /usr/include/urt
	doins include/*.h || die "doins include"
	doman man/man?/*.[135]
	dodoc *-changes CHANGES* README blurb
}
