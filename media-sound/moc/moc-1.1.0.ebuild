# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-1.1.0.ebuild,v 1.10 2004/11/17 00:27:30 eradicator Exp $

IUSE="oggvorbis mad oss"

inherit eutils

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
HOMEPAGE="http://moc.daper.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"

DEPEND="media-libs/libao
	sys-libs/ncurses
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-libs/libmad sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
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
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
