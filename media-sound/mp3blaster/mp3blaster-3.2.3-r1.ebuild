# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3blaster/mp3blaster-3.2.3-r1.ebuild,v 1.5 2007/08/17 01:58:09 drac Exp $

DESCRIPTION="Text console based program for playing audio files."
HOMEPAGE="http://mp3blaster.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86"
LICENSE="GPL-2"
IUSE="esd lirc sdl sid vorbis"

RDEPEND=">=sys-libs/ncurses-5.2
	lirc? ( app-misc/lirc )
	vorbis? ( >=media-libs/libvorbis-1 )
	sid? ( =media-libs/libsidplay-1* )
	esd? ( media-sound/esound )
	sdl? ( media-libs/libsdl )"
DEPEND="${RDEPEND}
	x11-misc/imake"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# File collision with media-sound/splay.
	sed -i -e "s:splay.1:splay_mp3blaster.1:" Makefile.in
	mv splay.1 splay_mp3blaster.1
}

src_compile() {
	local myconf

	# newthreads and libpth support is broken.
	if use sdl; then
		myconf="${myconf} --disable-newthreads --without-pth --with-sdl --with-oss"
	else
		myconf="${myconf} --disable-newthreads --without-pth --with-oss"
	fi

	econf --without-nas ${myconf} \
		$(use_with lirc) \
		$(use_with vorbis oggvorbis) \
		$(use_with sid sidplay) \
		$(use_with esd)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	# File collision with media-sound/splay.
	mv "${D}"/usr/bin/splay "${D}"/usr/bin/splay_mp3blaster
	dodoc AUTHORS BUGS ChangeLog CREDITS FAQ NEWS README TODO
}
