# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundtracker/soundtracker-0.6.8.ebuild,v 1.3 2007/08/22 22:22:41 ticho Exp $

IUSE="alsa esd jack nls oss sdl"

inherit eutils

S=${WORKDIR}/${P/_/-}

DESCRIPTION="SoundTracker is a music tracking tool for UNIX/X11 (MOD tracker)"
SRC_URI="http://www.soundtracker.org/dl/v0.6/${P/_/-}.tar.gz"
HOMEPAGE="http://www.soundtracker.org"

RDEPEND="sys-libs/zlib
	=x11-libs/gtk+-1.2*
	>=media-libs/audiofile-0.2.1
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	jack? ( media-sound/jack-audio-connection-kit )
	sdl? ( >=media-libs/libsdl-1.2.0 )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	app-arch/bzip2
	app-arch/gzip
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-0.6.7-execstack.patch"
}

src_compile() {
	local myconf

	use oss || myconf="--disable-oss"
	use esd || myconf="${myconf} --disable-esd"
	use nls || myconf="${myconf} --disable-nls"
	use alsa || myconf="${myconf} --disable-alsa"
	myconf="${myconf} --disable-gnome"
	use x86 && myconf="${myconf} --enable-asm"
	use jack || myconf="${myconf} --disable-jack"
	use sdl || myconf="${myconf} --disable-sdl"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "make install failed"
	#borks make DESTDIR=${D} install || die "make install failed"

	# strip suid from binary
	chmod -s ${D}/usr/bin/soundtracker

	# documentation
	dodoc AUTHORS ChangeLog* FAQ NEWS README TODO
	dodoc doc/*.txt
	dohtml -r doc

	doicon soundtracker_splash.png
	make_desktop_entry soundtracker SoundTracker soundtracker_splash.png
}
