# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundtracker/soundtracker-0.6.7.ebuild,v 1.2 2004/03/23 07:14:41 eradicator Exp $

IUSE="nls esd gnome oss alsa jack"

inherit eutils

S=${WORKDIR}/${P/_/-}

DESCRIPTION="SoundTracker is a music tracking tool for UNIX/X11 (MOD tracker)"
SRC_URI="http://www.soundtracker.org/dl/v0.6/${P/_/-}.tar.gz"
HOMEPAGE="http://www.soundtracker.org"

DEPEND="sys-libs/zlib
	=x11-libs/gtk+-1.2*
	>=media-libs/audiofile-0.2.1
	dev-util/pkgconfig
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.7 )
	nls? ( sys-devel/gettext )
	jack? ( virtual/jack )"

RDEPEND="${DEPEND}
	app-arch/bzip2
	app-arch/gzip
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-alsa1.patch
}

src_compile() {
	replace-flags "-O3" "-O2"

	local myconf

	use oss || myconf="--disable-oss"
	use esd || myconf="${myconf} --disable-esd"
	use nls || myconf="${myconf} --disable-nls"
	use alsa || myconf="${myconf} --disable-alsa"
	use gnome || myconf="${myconf} --disable-gnome"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "make install failed"
	#borks make DESTDIR=${D} install || die "make install failed"

	# strip suid from binary
	chmod -s ${D}/usr/bin/soundtracker

	# documentation
	dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README TODO
	dodoc doc/*.txt
	dohtml -r doc
}
