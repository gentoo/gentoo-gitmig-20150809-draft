# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.4-r1.ebuild,v 1.4 2004/03/31 19:37:15 eradicator Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

IUSE="alsa oss oggvorbis mad encode"
KEYWORDS="x86 amd64"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="virtual/glibc
	oggvorbis? media-libs/libvorbis
	mad? media-sound/mad"

src_compile () {
	# 12.17.4 has mp3 encoding/decoding if you have madlibs and lame
	# using alsa by default
	local myconf

	use oggvorbis || myconf="${myconf} --disable-ogg-vorbis"
	use mad || myconf="${myconf} --disable-mad"
	use encode || myconf="${myconf} --disable-lame"
	use alsa || myconf="${myconf} --disable-alsa-dsp"
	use oss || myconf="${myconf} --disable-oss-dsp"

	econf ${myconf} --enable-fast-ulaw --enable-fast-alaw || die
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

