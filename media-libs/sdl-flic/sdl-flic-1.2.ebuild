# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-flic/sdl-flic-1.2.ebuild,v 1.1 2004/12/27 03:12:57 vapier Exp $

inherit eutils

DESCRIPTION="FLIC animation file loading library"
HOMEPAGE="http://www.geocities.com/andre_leiradella/#sdl_flic"
SRC_URI="http://www.geocities.com/andre_leiradella/SDL_flic-12.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/zlib
	>=media-libs/libsdl-1.2.4"

S="${WORKDIR}"/SDL_flic-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-win32.patch
	cp ${FILESDIR}/Makefile .
	edos2unix SDL_flic.h
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README.txt
}
