# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.4.ebuild,v 1.3 2003/09/07 00:06:06 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~alpha ~sparc "
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="virtual/glibc"

src_compile () {
	# 12.17.4 has mp3 encoding/decoding if you have madlibs and lame
	# using alsa by default
	econf --enable-fast-ulaw --enable-fast-alaw || die
	emake || die
}

src_install () {
	into /usr
	dobin sox play soxeffect soxmix
	doman sox.1 play.1 soxexam.1
	dodoc Changelog Copyright README TODO *.txt
}

pkg_postinst () {
	# the rec binary doesnt exist anymore
	if([ ! -e /usr/bin/rec ]) then
		ln -s /usr/bin/play /usr/bin/rec
	fi
}
