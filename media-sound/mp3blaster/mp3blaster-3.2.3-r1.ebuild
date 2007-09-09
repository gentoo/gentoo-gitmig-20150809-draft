# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3blaster/mp3blaster-3.2.3-r1.ebuild,v 1.8 2007/09/09 00:10:27 josejx Exp $

DESCRIPTION="Text console based program for playing audio files"
HOMEPAGE="http://mp3blaster.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="esd lirc oss sdl sid vorbis"

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
	if ! use esd && ! use sdl && ! use oss ; then
		ewarn "You've disabled esd, sdl, and oss.  Enabling oss for you."
		myconf="--with-oss"
	fi

	# newthreads and libpth support is broken.
	econf \
		--disable-newthreads \
		--without-pth \
		--without-nas \
		$(use_with lirc) \
		$(use_with vorbis oggvorbis) \
		$(use_with sid sidplay) \
		$(use_with esd) \
		$(use_with sdl) \
		$(use_with oss) \
		${myconf} \
		|| die
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	# File collision with media-sound/splay.
	mv "${D}"/usr/bin/splay "${D}"/usr/bin/splay_mp3blaster || die
	dodoc AUTHORS BUGS ChangeLog CREDITS FAQ NEWS README TODO
}
