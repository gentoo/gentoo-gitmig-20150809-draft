# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.70.4.ebuild,v 1.2 2003/05/09 13:22:08 jje Exp $

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ~ppc"

DEPEND="dev-libs/glib
	>=media-libs/alsa-lib-0.9.0_rc2
	>=media-libs/libsndfile-1.0.0
	>=x11-libs/fltk-1.1.1
	!media-sound/jack-cvs"

PROVIDE="virtual/jack"

src_compile() {
	export LDFLAGS="${LDFLAGS} -L/usr/lib/fltk-1.1"
	export CPPFLAGS="${CPPFLAGS} -I/usr/include/fltk-1.1"

	econf || die "./configure failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
