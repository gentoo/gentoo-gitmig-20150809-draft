# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.3.ebuild,v 1.3 2002/07/12 21:19:52 phoenix Exp $

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"

KEYWORDS="x86"
SLOT="0"
LICENSE="LPGL-2.1"
SRC_URI="http://download.sourceforge.net/sox/${P}.tar.gz"
S=${WORKDIR}/${P}

DEPEND="virtual/glibc"

src_compile () {
	# Looks like support for alsa09's dsp is broken in sox; disabling it for now.
	local myconf
	./configure --prefix=/usr --host=${CHOST} \
		--enable-fast-ulaw --enable-fast-alaw $myconf || die
	emake || die
}

src_install () {
	into /usr
	dobin sox play soxeffect
	doman sox.1 soxexam.1
	dodoc Changelog Copyright README TODO *.txt
}

pkg_postinst () {
	# the rec binary doesnt exist anymore
	if([ ! -e /usr/bin/rec ]) then
		ln -s /usr/bin/play /usr/bin/rec 
	fi
}
