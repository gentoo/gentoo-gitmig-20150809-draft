# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.34.0.ebuild,v 1.1 2002/06/06 12:22:31 stroke Exp $

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"

# libjack is LGPL, the rest is GPL
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

DEPEND="dev-libs/glib
        >=media-libs/alsa-lib-0.9.0_rc1"

RDEPEND="${DEPEND}"

SRC_URI="http://download.sf.net/jackit/${P}.tar.gz"

src_compile() {

	econf || die "./configure failed"
	emake || die "compilation failed"
}

src_install () {

	make DESTDIR=${D} DOC_DIR=${D}/usr/share/doc/${P} install || die
	dodoc README
}
