# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tapiir/tapiir-0.7.1.ebuild,v 1.6 2004/01/22 11:08:53 torbenh Exp $

DESCRIPTION=" Tapiir is a simple and flexible audio effects processor, inspired on the classical magnetic tape delay systems"
HOMEPAGE="http://www.iua.upf.es/~mdeboer/projects/tapiir/"
SRC_URI="ftp://www.iua.upf.es/pub/mdeboer/projects/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86"

DEPEND="virtual/jack
	>=media-libs/alsa-lib-0.9
	x11-libs/fltk"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gcc3.patch
	sed -i "/#include <alsa\\/asoundlib.h>/i\\#define ALSA_PCM_OLD_HW_PARAMS_API 1\\" src/alsaio.cxx
}

src_compile() {
	local myconf
	myconf="--with-fltk-prefix=/usr/lib/fltk-1.1 \
		--with-fltk-inc-prefix=/usr/include/fltk-1.1"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS
}
