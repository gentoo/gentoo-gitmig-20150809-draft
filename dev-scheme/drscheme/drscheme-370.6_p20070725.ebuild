# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/drscheme/drscheme-370.6_p20070725.ebuild,v 1.1 2007/07/25 16:44:27 hkbst Exp $

inherit eutils multilib flag-o-matic libtool

DESCRIPTION="DrScheme programming environment. Includes mzscheme."
HOMEPAGE="http://www.plt-scheme.org/software/drscheme/"

MY_PV=${PV%%_p*}

SRC_URI="mirror://gentoo/plt-${MY_PV}-src-unix.tgz"
#         http://pre.plt-scheme.org/installers/plt-${PV}-src-unix.tgz
#         http://download.plt-scheme.org/bundles/${PV}/plt/plt-${PV}-src-unix.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cgc backtrace cairo doc llvm opengl profile X xft xrender"

RDEPEND="X? ( x11-libs/libICE
			  x11-libs/libSM
			  x11-libs/libXaw
			  xft? ( >=x11-libs/libXft-2.1.12 )
			  xrender? ( x11-libs/libXrender )
			  media-libs/freetype
			  media-libs/fontconfig
			  cairo? ( x11-libs/cairo )
			  media-libs/jpeg
			  opengl? ( virtual/opengl )
			  media-libs/libpng )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/plt-${MY_PV}"

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
		$(use_enable xft) \
		$(use_enable xrender) \
		|| die "econf failed"

	emake -j1 || die "emake failed"

	if use cgc; then
		emake cgc || die "emake cgc failed"
	fi
}

src_install() {
	cd src
	export MZSCHEME_DYNEXT_LINKER_FLAGS=$(raw-ldflags)

	emake DESTDIR="${D}" install || die "make install failed"

	if use cgc; then
		emake DESTDIR="${D}" install-cgc || die "make install-cgc failed"
	fi

	use doc && mv -f "${D}"/usr/share/plt/doc/* "${D}/usr/share/doc/${PF}/"
	rm -rf "${D}/usr/share/plt/doc"

	# needed so online help works
	keepdir /usr/share/plt
	dosym "/usr/share/doc/${PF}" "/usr/share/plt/doc"

	if use X; then
		newicon ../collects/icons/PLT-206.png drscheme.png
		make_desktop_entry drscheme "DrScheme" drscheme.png "Development"
	fi
}
