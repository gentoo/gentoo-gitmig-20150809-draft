# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-patch-bay/alsa-patch-bay-0.5.1-r1.ebuild,v 1.6 2004/04/08 07:45:26 eradicator Exp $

DESCRIPTION="Graphical patch bay for the ALSA sequencer API."
HOMEPAGE="http://pkl.net/~node/alsa-patch-bay.html"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE="fltk"

# The package defaults to the gtkmm graphics library.
# To use fltk instead, do $ USE="fltk" emerge alsa-patch-bay
# Note: fltk is not an official USE flag, and the dependency on
# it may go away in the future.
DEPEND="!fltk? >=dev-cpp/gtkmm-2.0
	fltk? >=x11-libs/fltk-1.1.2
	>=media-libs/alsa-lib-0.9.0_rc1"

SRC_URI="http://pkl.net/~node/software/${P}.tar.gz"

src_compile() {
	local myconf
	use fltk || myconf="--disable-fltk"
	./configure ${myconf} \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	einstall APB_DESKTOP_PREFIX=${D}/usr/share || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}

pkg_preinst() {
	if [ -e ${D}/usr/bin/jack-patch-bay ]
	then
		rm ${D}/usr/bin/jack-patch-bay
		ln -s alsa-patch-bay ${D}/usr/bin/jack-patch-bay
	fi
}
