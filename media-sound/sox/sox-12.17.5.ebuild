# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit gnuconfig eutils

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

IUSE="oggvorbis mad encode" # alsa oss
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips ~alpha"
LICENSE="LGPL-2.1"

DEPEND="virtual/libc
	encode? ( media-sound/lame )
	alsa? ( media-libs/alsa-lib )
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-sound/madplay )"

src_compile () {
	# Needed on mips and probablly others
	gnuconfig_update

	# from version 12.17.4 sox has mp3 encoding/decoding if you have madlibs 
	# and lame using alsa by default
	local myconf

	epatch ${FILESDIR}/${PN}-soundcard.patch
	epatch ${FILESDIR}/${PN}-install.patch

	myconf="${myconf} `use_enable oggvorbis ogg-vorbis`"
	myconf="${myconf} `use_enable mad`"
	myconf="${myconf} `use_enable encode lame`"
	myconf="${myconf} --enable-oss-dsp"
#	myconf="${myconf} `use_enable oss oss-dsp`"
#	myconf="${myconf} `use_enable alsa alsa-dsp`"

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
