# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsamixergui/alsamixergui-0.9.0.1.2-r1.ebuild,v 1.2 2002/09/21 18:20:39 vapier Exp $

NATIVE_VER=0.9.0rc1-2
S=${WORKDIR}/${PN}-${NATIVE_VER}

DESCRIPTION="AlsaMixerGui - a FLTK based amixer Frontend"
HOMEPAGE="http://www.iua.upf.es/~mdeboer/projects/alsamixergui/"
SRC_URI="ftp://www.iua.upf.es/pub/mdeboer/projects/alsamixergui/${PN}-${NATIVE_VER}.tar.gz"

DEPEND=">=media-sound/alsa-driver-0.9.0_rc1
	>=media-libs/alsa-lib-0.9.0_rc1
	>=media-sound/alsa-utils-0.9.0_rc1
	>=x11-libs/fltk-1.1.0_rc6"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/fltk-1.1+gcc3.diff || die "patch failed"

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
