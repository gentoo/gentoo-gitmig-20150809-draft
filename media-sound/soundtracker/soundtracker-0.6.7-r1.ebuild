# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundtracker/soundtracker-0.6.7-r1.ebuild,v 1.3 2006/04/28 12:08:14 flameeyes Exp $

IUSE="nls esd gnome oss alsa jack"

inherit eutils flag-o-matic

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
	gnome? ( >=gnome-base/gnome-libs-1.4.1.7 )
	jack? ( media-sound/jack-audio-connection-kit )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	app-arch/bzip2
	app-arch/gzip
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-alsa1.patch"
	epatch "${FILESDIR}/${P}-invalid-free.patch"
	epatch "${FILESDIR}/${P}-execstack.patch"
}

src_compile() {
	replace-flags "-O3" "-O2"

	local myconf

	use oss || myconf="--disable-oss"
	use esd || myconf="${myconf} --disable-esd"
	use nls || myconf="${myconf} --disable-nls"
	use alsa || myconf="${myconf} --disable-alsa"
	use gnome || myconf="${myconf} --disable-gnome"
	use x86 || myconf="${myconf} --disable-asm"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "make install failed"
	#borks make DESTDIR=${D} install || die "make install failed"

	# strip suid from binary
	chmod -s ${D}/usr/bin/soundtracker

	# documentation
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
	dodoc doc/*.txt
	dohtml -r doc
}
