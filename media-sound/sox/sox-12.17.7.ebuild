# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.7.ebuild,v 1.1 2005/02/18 16:51:57 luckyduck Exp $

IUSE="oggvorbis mad encode alsa"

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
LICENSE="LGPL-2.1"

DEPEND="virtual/libc
	encode? ( media-sound/lame )
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-sound/madplay )
	alsa? ( media-libs/alsa-lib )"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Needed on mips and probablly others
	gnuconfig_update

	epatch ${FILESDIR}/${P}-destdir.patch
}

src_compile () {
	# from version 12.17.4 sox has mp3 encoding/decoding if you have madlibs 
	# and lame using alsa by default
	local myconf

	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	myconf="${myconf} `use_enable oggvorbis ogg-vorbis`"
	myconf="${myconf} `use_enable mad`"
	myconf="${myconf} `use_enable encode lame`"
#	myconf="${myconf} `use_enable oss oss-dsp`"
	myconf="${myconf} --enable-oss-dsp"
	myconf="${myconf} `use_enable alsa alsa-dsp`"

	econf ${myconf} \
		--enable-fast-ulaw \
		--enable-fast-alaw || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	prepallman

	dodoc Changelog README TODO *.txt
}
