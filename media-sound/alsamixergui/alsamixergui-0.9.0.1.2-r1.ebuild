# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsamixergui/alsamixergui-0.9.0.1.2-r1.ebuild,v 1.10 2004/03/31 17:52:37 eradicator Exp $

inherit eutils

NATIVE_VER=0.9.0rc1-2
S=${WORKDIR}/${PN}-${NATIVE_VER}

DESCRIPTION="AlsaMixerGui - a FLTK based amixer Frontend"
HOMEPAGE="http://www.iua.upf.es/~mdeboer/projects/alsamixergui/"
SRC_URI="ftp://www.iua.upf.es/pub/mdeboer/projects/alsamixergui/${PN}-${NATIVE_VER}.tar.gz"

DEPEND="virtual/alsa
	>=media-libs/alsa-lib-0.9.0_rc1
	>=media-sound/alsa-utils-0.9.0_rc1
	>=x11-libs/fltk-1.1.0_rc6"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/fltk-1.1+gcc3.diff
}

src_compile() {

	export LDFLAGS="-L/usr/lib/fltk-1.1"
	export CPPFLAGS="-I/usr/include/fltk-1.1"

	econf || die "configure failed"

	emake || die "make failed"

}

src_install () {

	einstall || die

	dodoc COPYING README AUTHORS ChangeLog

}
