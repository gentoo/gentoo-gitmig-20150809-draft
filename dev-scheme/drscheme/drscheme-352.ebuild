# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/drscheme/drscheme-352.ebuild,v 1.3 2006/09/07 21:34:02 chutzpah Exp $

inherit eutils multilib

DESCRIPTION="DrScheme programming environment.  Includes mzscheme."
HOMEPAGE="http://www.plt-scheme.org/software/drscheme/"
SRC_URI="http://download.plt-scheme.org/bundles/${PV}/plt/plt-${PV}-src-unix.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="backtrace cairo jpeg opengl perl png sgc"

RDEPEND="|| ( ( x11-libs/libICE
			x11-libs/libSM
			x11-libs/libXaw
			x11-libs/libXft
		)
		virtual/x11
	)
	!dev-scheme/mzscheme
	media-libs/freetype
	media-libs/fontconfig
	cairo? ( x11-libs/cairo )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/plt/src"
GL_COLLECTS="sgl games/gobblet games/checkers games/jewel games/gl-board-game"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/plt"

	epatch "${FILESDIR}/${PN}-350-fPIC.patch"

	if ! use opengl ; then
		# move aside the opengl-dependent stuff or install will fail
		mkdir collects-disabled

		for dir in ${GL_COLLECTS}; do
			mv -f collects/${dir} collects-disabled/$(basename ${dir})
		done
	fi
}

src_compile() {
	# needed because drschme uses it's own linker that passes LDFLAGS directly
	# to the linker, rather than passing it through gcc
	LDFLAGS="${LDFLAGS//-Wl/}"
	LDFLAGS="${LDFLAGS//,/ }"

	econf --enable-mred \
		$(use_enable backtrace) \
		$(use_enable cairo) \
		$(use_enable jpeg libjpeg) \
		$(use_enable opengl gl) \
		$(use_enable perl) \
		$(use_enable png libpng) \
		$(use_enable sgc) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ${WORKDIR}/plt/{readme.txt,src/README}

	mv -f "${D}"/usr/share/plt/doc/* "${D}/usr/share/doc/${P}/"
	rm -rf "${D}/usr/share/plt/doc"

	# needed so online help works
	keepdir /usr/share/plt
	dosym "/usr/share/doc/${P}" "/usr/share/plt/doc"

	newicon "${WORKDIR}/plt/collects/icons/PLT-206.png" drscheme.png
	make_desktop_entry drscheme "DrScheme" drscheme.png "Development"
}
