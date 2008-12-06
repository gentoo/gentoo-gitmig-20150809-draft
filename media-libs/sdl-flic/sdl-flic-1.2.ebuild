# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-flic/sdl-flic-1.2.ebuild,v 1.5 2008/12/06 16:50:21 nyhm Exp $

inherit eutils

DESCRIPTION="FLIC animation file loading library"
HOMEPAGE="http://www.geocities.com/andre_leiradella/#sdl_flic"
SRC_URI="http://www.geocities.com/andre_leiradella/SDL_flic-12.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~mips ~ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl"

S=${WORKDIR}/SDL_flic-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-win32.patch"
	cp "${FILESDIR}/Makefile" .
	edos2unix SDL_flic.h
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt
}
