# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-1.1.0.ebuild,v 1.9 2004/09/24 18:37:26 swegener Exp $

inherit eutils

IUSE="oggvorbis mad oss"

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://moc.daper.net/"

DEPEND="media-libs/libao
	sys-libs/ncurses
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-libs/libmad sys-libs/zlib )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.patch
}

src_compile() {
	local myconf
	use oggvorbis || myconf="--without-ogg"
	use mad || myconf="${myconf} --without-mp3"
	use oss || myconf="${myconf} --without-oss"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
}
