# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.6.ebuild,v 1.1 2004/11/20 18:46:42 chainsaw Exp $

inherit gnuconfig flag-o-matic

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

IUSE="oggvorbis mad encode" # alsa oss
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips ~alpha"
LICENSE="LGPL-2.1"

DEPEND="virtual/libc
	encode? ( media-sound/lame )
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-sound/madplay )"
#	alsa? ( media-libs/alsa-lib )

src_compile () {
	# Needed on mips and probablly others
	gnuconfig_update

	# from version 12.17.4 sox has mp3 encoding/decoding if you have madlibs 
	# and lame using alsa by default
	local myconf

	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	myconf="${myconf} `use_enable oggvorbis ogg-vorbis`"
	myconf="${myconf} `use_enable mad`"
	myconf="${myconf} `use_enable encode lame`"
	myconf="${myconf} --enable-oss-dsp"
#	myconf="${myconf} `use_enable oss oss-dsp`"
#	myconf="${myconf} `use_enable alsa alsa-dsp`"

#	SoX currently targets the ALSA kernel API and not alsa-lib. This is a problem because the interface changes.
#	see bug #63531 for more details
# 	The build will automatically disable ALSA support even if it's in USE
	myconf="${myconf} --disable-alsa-dsp"
	einfo "Notice.. ALSA support is currently broken in sox. ALSA support has been disabled."
	einfo "sox will automatically use OSS, if you have ALSA then it'll work through the"
	einfo "compatiblity layer."

	econf ${myconf} \
		--enable-fast-ulaw \
		--enable-fast-alaw || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
	prepallman

	dodoc Changelog README TODO *.txt
}
