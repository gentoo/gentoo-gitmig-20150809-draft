# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author J. Findeisen <you@hanez.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsamixergui/alsamixergui-0.9.0_rc2.ebuild,v 1.1 2002/05/24 07:34:19 agenkin Exp $

DESCRIPTION="AlsaMixerGui - a FLTK based amixer Frontend"
HOMEPAGE="http://www.iua.upf.es/~mdeboer/projects/alsamixergui/"

DEPEND="virtual/glibc
	>=media-sound/alsa-driver-0.9.0_rc1-r1
	>=media-sound/alsa-utils-0.9.0_rc1
	>=x11-libs/fltk-1.0.11"

SRC_URI="ftp://www.iua.upf.es/pub/mdeboer/projects/alsamixergui/alsamixergui-0.9.0rc1-2.tar.gz"
S=${WORKDIR}/alsamixergui-0.9.0rc1-2

src_compile() {
	cd ${S}
	./configure || die "./configure failed"
	make || die
}

src_install () {
	cd ${S}
	make DESTDIR=${D} install || die
	dodoc COPYING README AUTHORS ChangeLog
}
