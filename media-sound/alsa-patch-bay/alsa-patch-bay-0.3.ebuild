# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-patch-bay/alsa-patch-bay-0.3.ebuild,v 1.5 2003/09/10 22:39:41 msterret Exp $

DESCRIPTION="Graphical patch bay for the ALSA sequencer API."
HOMEPAGE="http://pkl.net/~node/alsa-patch-bay.html"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-cpp/gtkmm-2.0.2
	>=media-sound/alsa-driver-0.9.0_rc1
	>=media-libs/alsa-lib-0.9.0_rc1
	>=media-sound/alsa-utils-0.9.0_rc1"

KEYWORDS="~x86"

# Alsa-patch-bay can use either gtkmm of fltk.	However, it fails to build
# against Gentoo's fltk, I believe because Gentoo's fltk is built as static.
# So we use gtkmm only. But I've included use variables in case fltk changes.
# In that case, we can add if-then statements to the ./configure section
#IUSE="fltk gtkmm"

SRC_URI="http://pkl.net/~node/software/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--disable-fltk || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}
