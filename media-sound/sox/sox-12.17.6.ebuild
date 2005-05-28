# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.6.ebuild,v 1.4 2005/05/28 16:08:31 luckyduck Exp $

inherit gnuconfig flag-o-matic

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~amd64 ~mips ~alpha"
IUSE="ogg mad encode" # alsa oss

DEPEND="virtual/libc
	encode? ( media-sound/lame )
	ogg? ( media-libs/libvorbis )
	mad? ( media-sound/madplay )"
#	alsa? ( media-libs/alsa-lib )

src_compile () {
	# Needed on mips and probablly others
	gnuconfig_update

	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	# SoX currently targets the ALSA kernel API and not alsa-lib. This is
	# a problem because the interface changes. see bug #63531 for more 
	# details. The build will automatically disable ALSA support even if
	# it's in USE
	einfo "Notice.. ALSA support is currently broken in sox. ALSA support"
	einfo "has been disabled. Sox will automatically use OSS, if you have"
	einfo "ALSA then it'll work through the compatiblity layer."

	econf \
		$(use_enable encode lame) \
		$(use_enable mad) \
		$(use_enable ogg ogg-vorbis) \
		${myconf} \
		--enable-fast-ulaw \
		--enable-fast-alaw \
		--enable-oss-dsp \
		--disable-alsa-dsp \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
	prepallman

	dodoc Changelog README TODO *.txt
}
