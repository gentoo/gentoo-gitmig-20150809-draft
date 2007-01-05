# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-2.1.4-r1.ebuild,v 1.2 2007/01/05 17:35:18 flameeyes Exp $

IUSE="vorbis mad oss"

inherit eutils

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
HOMEPAGE="http://moc.daper.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 sparc x86"

DEPEND="media-libs/libao
	sys-libs/ncurses
	vorbis? ( media-libs/libvorbis )
	mad? ( media-libs/libmad sys-libs/zlib media-libs/libid3tag )"

src_compile() {
	local myconf
	use vorbis || myconf="--without-ogg"
	use mad || myconf="${myconf} --without-mp3"
	use oss || myconf="${myconf} --without-oss"

	econf ${myconf} || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "The binary was renamed due to conflicts with moc"
	elog "from the QT project. Its new name is mocp."
}
