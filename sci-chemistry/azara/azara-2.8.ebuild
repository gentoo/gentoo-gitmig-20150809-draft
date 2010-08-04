# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/azara/azara-2.8.ebuild,v 1.1 2010/08/04 14:52:26 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit eutils python toolchain-funcs

DESCRIPTION="A suite of programmes to process and view NMR data"
HOMEPAGE="http://www.bio.cam.ac.uk/azara/"
SRC_URI="http://www.bio.cam.ac.uk/ccpn/download/${PN}/${P}-src.tgz"

LICENSE="AZARA"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="X xpm"

RDEPEND="
	xpm? ( x11-libs/libXpm )
	X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	cat > ENVIRONMENT <<- EOF
	CC=$(tc-getCC)
	CFLAGS=${CFLAGS}
	LFLAGS=${LDFLAGS}
	MATH_LIB=-lm
	X11_INCLUDE_DIR=-I${EPREFIX}/usr/X11R6/include
	MOTIF_INCLUDE_DIR=-I${EPREFIX}/usr/include
	X11_LIB_DIR=-L${EPREFIX}/usr/$(get_libdir)
	MOTIF_LIB_DIR=-L${EPREFIX}/usr/$(get_libdir)
	X11_LIB=-lX11
	MOTIF_LIB=-lXm -lXt
	PYTHON_INCLUDE_DIR=$(python_get_includedir)
	SHARED_FLAGS = -shared
	ENDIAN_FLAG=-DLITTLE_ENDIAN_DATA
	EOF

	use xpm && echo "XPMUSE=\"XPM_FLAG=-DUSE_XPM XPM_LIB=-lXpm\"" >> ENVIRONMENT

	epatch "${FILESDIR}"/${PV}-prll.patch
	epatch "${FILESDIR}"/${PV}-impl-dec.patch
}

src_compile() {
	local mymake
	local makeflags

	mymake="${mymake} help nongui DataRows"
	use X && mymake="${mymake} gui"

	emake ${mymake} || die
}

src_install() {
	rm bin/pythonAzara || die
	if ! use X; then
		rm bin/plot* || die
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
