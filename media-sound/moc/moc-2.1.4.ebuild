# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-2.1.4.ebuild,v 1.1 2005/01/21 18:33:10 luckyduck Exp $

IUSE="oggvorbis mad oss"

inherit eutils

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
HOMEPAGE="http://moc.daper.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 sparc x86"

DEPEND="media-libs/libao
	sys-libs/ncurses
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-libs/libmad sys-libs/zlib media-libs/libid3tag )"

src_compile() {
	local myconf
	use oggvorbis || myconf="--without-ogg"
	use mad || myconf="${myconf} --without-mp3"
	use oss || myconf="${myconf} --without-oss"

	econf ${myconf} || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	# the binary was renamed to mocp in version 2
	dosym /usr/bin/mocp /usr/bin/moc
}
