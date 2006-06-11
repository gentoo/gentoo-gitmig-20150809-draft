# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aacgain/aacgain-1.5.ebuild,v 1.2 2006/06/11 20:57:20 sbriesen Exp $

inherit eutils

DESCRIPTION="AACGain normalizes the volume of digital music files using the Replay Gain algorithm."
HOMEPAGE="http://altosdesign.com/aacgain/"
SRC_URI="http://altosdesign.com/aacgain/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc aacgain/README README.first
}

pkg_postinst() {
	ewarn
	ewarn "BACK UP YOUR MUSIC FILES BEFORE USING AACGAIN!"
	ewarn "THIS IS EXPERIMENTAL SOFTWARE. THERE HAVE BEEN"
	ewarn "BUGS IN PAST RELEASES THAT CORRUPTED MUSIC FILES."
	ewarn
}
