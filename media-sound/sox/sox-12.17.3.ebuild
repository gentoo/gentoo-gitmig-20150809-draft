# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.3.ebuild,v 1.2 2002/07/11 06:30:41 drobbins Exp $

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"

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
