# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.7-r1.ebuild,v 1.1 2005/03/10 14:33:30 luckyduck Exp $

IUSE="alsa encode mad oggvorbis"

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86 ~hppa"
LICENSE="LGPL-2.1"

DEPEND="virtual/libc
	encode? ( media-sound/lame )
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-libs/libmad )
	alsa? ( media-libs/alsa-lib )"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Needed on mips and probablly others
	gnuconfig_update

	epatch ${FILESDIR}/${P}-destdir.patch
}

src_compile () {
	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	econf ${myconf} \
		$(use_enable oggvorbis ogg-vorbis) \
		$(use_enable mad) \
		$(use_enable encode lame) \
		$(use_enable alsa alsa-dsp) \
		--enable-oss-dsp \
		--enable-fast-ulaw \
		--enable-fast-alaw || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	prepallman

	dodoc Changelog README TODO *.txt
}
