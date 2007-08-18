# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/drscheme/drscheme-371.ebuild,v 1.1 2007/08/18 10:05:57 hkbst Exp $

inherit eutils

SRC_URI="http://download.plt-scheme.org/bundles/${PV}/plt/plt-${PV}-src-unix.tgz
		 http://pre.plt-scheme.org/installers/plt-${PV}-src-unix.tgz"
#"mirror://gentoo/plt-${PV%%_p*}-src-unix.tgz"



DESCRIPTION="DrScheme programming environment. Includes mzscheme."
HOMEPAGE="http://www.plt-scheme.org/software/drscheme/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="backtrace cairo cgc llvm opengl profile X"

RDEPEND="X? ( x11-libs/libICE
			  x11-libs/libSM
			  x11-libs/libXaw
			  >=x11-libs/libXft-2.1.12
			  x11-libs/libXrender
			  media-libs/freetype
			  media-libs/fontconfig
			  cairo? ( x11-libs/cairo )
			  media-libs/jpeg
			  opengl? ( virtual/opengl )
			  media-libs/libpng )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/plt-${PV%%_p*}"

src_unpack() {
	unpack ${A}; cd "${S}"
	sed "s,docdir=\"\${datadir}/plt/doc,docdir=\"\${datadir}/doc/${PF}," -i src/configure
}

src_compile() {
	cd src

# according to vapier, we should use the bundled libtool
# such that we don't preclude cross-compile. Thus don't use
# --enable-lt=/usr/bin/libtool
	econf $(use_enable X mred) \
		--enable-shared \
		--disable-perl \
		$(use_enable backtrace) \
		$(use_enable cairo) \
		$(use_enable llvm) \
		$(use_enable opengl gl) \
		$(use_enable profile gprof) \
		--enable-xft \
		--enable-xrender

	if use cgc; then
		emake -j1 both || die "emake both failed"
	else
		emake -j1 || die "emake failed"
	fi
}

src_install() {
	cd src
	export MZSCHEME_DYNEXT_LINKER_FLAGS=$(raw-ldflags)

	if use cgc; then
		emake DESTDIR="${D}" install-both || die "emake install-both failed"
	else
		emake DESTDIR="${D}" install || die "emake install failed"
	fi

	if use X; then
		newicon ../collects/icons/PLT-206.png drscheme.png
		make_desktop_entry drscheme "DrScheme" drscheme.png "Development"
	fi
}
