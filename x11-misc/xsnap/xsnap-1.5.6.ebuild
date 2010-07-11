# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsnap/xsnap-1.5.6.ebuild,v 1.6 2010/07/11 14:53:32 armin76 Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Program to interactively take a 'snapshot' of a region of the screen"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/Xutils/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

COMMON_DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	media-libs/libpng
	media-libs/jpeg"
RDEPEND="${COMMON_DEPEND}
	media-fonts/font-misc-misc"
DEPEND="${COMMON_DEPEND}
	x11-proto/xproto
	app-text/rman
	x11-misc/imake"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	xmkmf || die
	sed -i \
		-e '/ CC = /d' \
		-e '/ LD = /d' \
		-e '/ CDEBUGFLAGS = /d' \
		-e '/ CCOPTIONS = /d' \
		-e 's|CPP = cpp|CPP = $(CC)|g' \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake CCOPTIONS="${CFLAGS}" EXTRA_LDOPTIONS="${LDFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install install.man || die
	dodoc README AUTHORS
}
