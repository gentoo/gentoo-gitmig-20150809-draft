# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.34.0-r2.ebuild,v 1.4 2003/01/08 00:16:04 raker Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirrors://sourceforge/jackit/${P}.tar.gz"

# libjack is LGPL, the rest is GPL
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86"

DEPEND="dev-libs/glib
	>=media-libs/alsa-lib-0.9.0_rc2
	>=media-libs/libsndfile-1.0.0
	>=x11-libs/fltk-1.1.1
	!media-sound/jack-cvs"
PROVIDE="virtual/jack"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/libsndfile-1.0.diff || die "patch failed"

}

src_compile() {

	export LDFLAGS="-L/usr/lib/fltk-1.1"                                    
        export CPPFLAGS="-I/usr/include/fltk-1.1"

	econf || die "./configure failed"
	emake || die "compilation failed"
}

src_install () {

	make DESTDIR=${D} DOC_DIR=${D}/usr/share/doc/${P} install || die
	dodoc README
}
