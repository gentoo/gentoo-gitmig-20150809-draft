# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-2.2.0.ebuild,v 1.2 2005/03/29 10:54:06 luckyduck Exp $

IUSE="flac mad oggvorbis oss"

inherit eutils

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
HOMEPAGE="http://moc.daper.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="media-libs/libao
	media-libs/libsndfile
	sys-libs/ncurses
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad sys-libs/zlib media-libs/libid3tag )
	oggvorbis? ( media-libs/libvorbis )"

src_compile() {
	local myconf
	use flac || myconf="${myconf} --without-flac"
	use mad || myconf="${myconf} --without-mp3"
	use oggvorbis || myconf="--without-ogg"
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
