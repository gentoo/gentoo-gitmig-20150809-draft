# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-midi/xmms-midi-0.03.ebuild,v 1.16 2005/08/07 13:05:35 hansmi Exp $

IUSE=""

inherit gnuconfig eutils

DESCRIPTION="Timidity++ Dependent MIDI Plugun for XMMS"
HOMEPAGE="http://ban.joh.cam.ac.uk/~cr212/xmms-midi/"
SRC_URI="http://ban.joh.cam.ac.uk/~cr212/xmms-midi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="media-sound/xmms
	media-sound/timidity++"

src_compile() {
	gnuconfig_update
	econf \
		--prefix=/usr/$(get_libdir) || die "econf failed"
		--with-xmms-prefix=/usr/include/xmms
	emake || die
}

src_install() {
	make DESTDIR=${D} libdir=`xmms-config --input-plugin-dir` install || die
	dodoc AUTHORS COPYING NEWS README
}

pkg_postinst() {
	einfo "*** WARNING: XMMS will play all MIDI files silently until a"
	einfo "working timidity.cfg has been placed in /etc!  If you don't"
	einfo "know how to do that, then just try emerging timidity-eawpatches"
}
