# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/azara/azara-2.7.ebuild,v 1.4 2010/08/04 14:52:26 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="A suite of programmes to process and view NMR data"
HOMEPAGE="http://www.bio.cam.ac.uk/azara/"
SRC_URI="http://www.bio.cam.ac.uk/ccpn/download/${PN}/${P}-src.tar.gz"

LICENSE="AZARA"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="opengl X xpm"

RDEPEND="
	xpm? ( x11-libs/libXpm )
	X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}"

src_prepare() {
	echo "" > ENVIRONMENT

#	epatch "${FILESDIR}"/help-makefile.patch
	epatch "${FILESDIR}"/${PV}-prll.patch
	epatch "${FILESDIR}"/${PV}-impl-dec.patch
}

src_compile() {
	local mymake
	local xpmuse
	local makeflags

	mymake="${mymake} help nongui"
	use X && mymake="${mymake} gui"
	use opengl && mymake="${mymake} gl"
	use xpm && XPMUSE="XPM_FLAG=-DUSE_XPM XPM_LIB=-lXpm"

	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		LFLAGS="${LDFLAGS}" \
		MATH_LIB="-lm" \
		X11_INCLUDE_DIR="-I${EPREFIX}/usr/X11R6/include" \
		MOTIF_INCLUDE_DIR="-I${EPREFIX}/usr/include" \
		X11_LIB_DIR="-L${EPREFIX}/usr/$(get_libdir)" \
		MOTIF_LIB_DIR="-L${EPREFIX}/usr/$(get_libdir)" \
		${XPMUSE} \
		X11_LIB="-lX11" \
		MOTIF_LIB="-lXm -lXt" \
		GL_INCLUDE_DIR="-I${EPREFIX}/usr/X11R6/include -I${EPREFIX}/usr/include" \
		GL_LIB_DIR="-I${EPREFIX}/usr/$(get_libdir)" \
		GL_LIB="-lglut -lGLU -lGL -lXmu -lX11 -lXext" \
		ENDIAN_FLAG="-DLITTLE_ENDIAN_DATA" \
		${mymake} || die
}

src_install() {
	if ! use X; then
		rm bin/plot* || die
	fi
	if ! use opengl; then
		rm bin/viewer || die
	fi
	for bin in bin/*; do
		dobin "${bin}" || die "failed to install ${bin}"
	done

	mv "${ED}"/usr/bin/{,azara-}extract || die "failed to fix extract collision"

	dodoc CHANGES* README* || die
	dohtml -r html/* || die
}

pkg_postinst() {
	einfo "Due to collision we moved the extract binary to azara-extract"
}
