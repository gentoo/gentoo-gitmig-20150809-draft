# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cuecue/cuecue-0.2.2.ebuild,v 1.3 2006/10/19 19:15:22 flameeyes Exp $

inherit eutils

DESCRIPTION="Cuecue is a suite to convert .cue + [.ogg|.flac|.wav|.mp3] to .cue + .bin."
HOMEPAGE="http://cuecue.berlios.de/"
SRC_URI="http://download.berlios.de/cuecue/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mp3 flac vorbis"

DEPEND="mp3? ( media-libs/libmad )
	flac? ( ~media-libs/flac-1.1.2 )
	vorbis? ( media-libs/libogg media-libs/libvorbis )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# remove obsolete CFLAGS
	sed -i -e "s:-g -Os::g" configure*
}

src_compile() {
	local myconf=""
	myconf="${myconf} $(use_enable mp3)"
	myconf="${myconf} $(use_enable flac)"
	myconf="${myconf} $(use_enable vorbis ogg)"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	insinto /usr/include
	doins src/libcuecue/cuecue.h
	dodoc CHANGES README TODO
}
