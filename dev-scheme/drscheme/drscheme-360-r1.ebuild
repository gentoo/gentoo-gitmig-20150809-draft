# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/drscheme/drscheme-360-r1.ebuild,v 1.2 2007/01/04 00:35:28 chutzpah Exp $

inherit eutils multilib flag-o-matic libtool

DESCRIPTION="DrScheme programming environment.  Includes mzscheme."
HOMEPAGE="http://www.plt-scheme.org/software/drscheme/"
SRC_URI="http://download.plt-scheme.org/bundles/${PV}/plt/plt-${PV}-src-unix.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="3m backtrace cairo jpeg opengl perl png sgc"

RDEPEND="x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXaw
	>=x11-libs/libXft-2.1.12
	!dev-scheme/mzscheme
	media-libs/freetype
	media-libs/fontconfig
	cairo? ( >=x11-libs/cairo-1.2.3 )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/plt-${PV}/src"

src_unpack() {
	unpack ${A}
	cd "${S}/.."

	epatch "${FILESDIR}/${PN}-350-fPIC.patch"
	epatch "${FILESDIR}/${P}-DESTDIR-3m.patch"

	cd "${S}/mzscheme/gc"
	elibtoolize
	cd "${S}"

	# lib dir fixups
	sed -ie 's:-rpath ${absprefix}/lib:-rpath ${absprefix}/'$(get_libdir)':g' configure
}

src_compile() {
	# needed because drschme uses it's own linker that passes LDFLAGS directly
	# to the linker, rather than passing it through gcc
	LDFLAGS="${LDFLAGS//-Wl/}"
	LDFLAGS="${LDFLAGS//,/ }"

	# -O3 seems to cause some miscompiles, this should fix #141925 and #133888
	replace-flags -O? -O2

	econf --enable-mred \
		--enable-shared \
		--enable-lt=/usr/bin/libtool \
		$(use_enable backtrace) \
		$(use_enable cairo) \
		$(use_enable jpeg libjpeg) \
		$(use_enable opengl gl) \
		$(use_enable perl) \
		$(use_enable png libpng) \
		$(use_enable sgc) \
		|| die "econf failed"

	emake || die "emake failed"

	if use 3m; then
		MAKEOPTS="${MAKEOPTS} -j1" emake 3m || die "emake 3m failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	if use 3m; then
		make DESTDIR="${D}" install-3m || die "make install failed"
	fi

	dodoc ${WORKDIR}/plt/{readme.txt,src/README}

	mv -f "${D}"/usr/share/plt/doc/* "${D}/usr/share/doc/${PF}/"
	rm -rf "${D}/usr/share/plt/doc"

	# needed so online help works
	keepdir /usr/share/plt
	dosym "/usr/share/doc/${PF}" "/usr/share/plt/doc"

	newicon "${WORKDIR}/plt-${PV}/collects/icons/PLT-206.png" drscheme.png
	make_desktop_entry drscheme "DrScheme" drscheme.png "Development"
}
