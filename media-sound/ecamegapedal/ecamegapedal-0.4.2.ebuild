# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ecamegapedal/ecamegapedal-0.4.2.ebuild,v 1.1 2003/06/21 04:00:07 jje Exp $

DESCRIPTION="Ecamegapedal is a real-time effect processor."
HOMEPAGE="http://www.wakkanet.fi/~kaiv/ecamegapedal/"
SRC_URI="http://ecasound.seul.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="x11-libs/qt \
	virtual/jack \
	media-sound/alsa-driver \
	media-sound/ecasound"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING NEWS README TODO
}

