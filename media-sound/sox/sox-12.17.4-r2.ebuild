# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.4-r2.ebuild,v 1.4 2004/10/17 23:43:09 josejx Exp $

inherit gnuconfig eutils flag-o-matic

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

IUSE="alsa oss oggvorbis mad encode"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ~mips alpha"
LICENSE="LGPL-2.1"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-sound/madplay )"

src_compile () {
	# Needed on mips and probablly others
	gnuconfig_update

	# 12.17.4 has mp3 encoding/decoding if you have madlibs and lame
	# using alsa by default
	local myconf

	# Wave buffer overflow fix.  Adresses Bug #57962
	epatch ${FILESDIR}/sox-wave-overflow.patch
	# Wave segfault fix.  Adresses Bug #35745
	append-flags -fsigned-char

	use oggvorbis || myconf="${myconf} --disable-ogg-vorbis"
	use mad || myconf="${myconf} --disable-mad"
	use encode || myconf="${myconf} --disable-lame"
	use alsa || myconf="${myconf} --disable-alsa-dsp"
	use oss || myconf="${myconf} --disable-oss-dsp"

	econf ${myconf} --enable-fast-ulaw --enable-fast-alaw || die
	emake || die
}

src_install() {
	dobin sox play soxeffect soxmix || die
	doman sox.1 play.1 soxexam.1
	dodoc Changelog README TODO *.txt
}

pkg_postinst() {
	# the rec binary doesnt exist anymore
	if [ ! -e ${ROOT}/usr/bin/rec ] ; then
		ln -s /usr/bin/play ${ROOT}/usr/bin/rec
	fi
}
