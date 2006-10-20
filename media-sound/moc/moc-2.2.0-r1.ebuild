# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-2.2.0-r1.ebuild,v 1.2 2006/10/20 22:25:55 flameeyes Exp $

inherit eutils

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
HOMEPAGE="http://moc.daper.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="flac mad oss vorbis"

DEPEND="media-libs/libao
	media-libs/libsndfile
	sys-libs/ncurses
	flac? ( ~media-libs/flac-1.1.2 )
	mad? ( media-libs/libmad sys-libs/zlib media-libs/libid3tag )
	vorbis? ( media-libs/libvorbis )"

src_compile() {
	local myconf
	use flac || myconf="${myconf} --without-flac"
	use mad || myconf="${myconf} --without-mp3"
	use vorbis || myconf="--without-ogg"
	use oss || myconf="${myconf} --without-oss"

	econf ${myconf} || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo "The binary was renamed due to conflicts with moc"
	einfo "from the QT project. Its new name is mocp."
}
