# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-midi/xmms-midi-0.03.ebuild,v 1.9 2004/04/26 03:49:03 agriffis Exp $

IUSE=""

inherit gnuconfig

DESCRIPTION="Timidity++ Dependent MIDI Plugun for XMMS"
HOMEPAGE="http://ban.joh.cam.ac.uk/~cr212/xmms-midi/"
SRC_URI="http://ban.joh.cam.ac.uk/~cr212/xmms-midi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

DEPEND="media-sound/xmms
	media-sound/timidity++"

src_compile() {
	gnuconfig_update
	econf \
		--prefix=/usr/lib || die "econf failed"
		--with-xmms-prefix=/usr/include/xmms
	emake || die
}

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Input install || die
	dodoc AUTHORS COPYING NEWS README
}

pkg_postinst() {
	if [ ! -f /etc/timidity.cfg ]
	then
		einfo "*** WARNING: XMMS will play all MIDI files silently until a"
		einfo "working timidity.cfg has been placed in /etc!"
	fi
}
