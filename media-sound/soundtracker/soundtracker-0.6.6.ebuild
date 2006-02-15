# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundtracker/soundtracker-0.6.6.ebuild,v 1.15 2006/02/15 13:39:16 flameeyes Exp $

IUSE="nls esd gnome oss alsa"

DESCRIPTION="SoundTracker is a music tracking tool for UNIX/X11 (MOD tracker)"
SRC_URI="http://www.soundtracker.org/dl/v0.6/${P}.tar.gz"
HOMEPAGE="http://www.soundtracker.org"

RDEPEND="sys-libs/zlib
	=x11-libs/gtk+-1.2*
	>=media-libs/audiofile-0.2.1
	alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.7 )"

DEPEND="${RDEPEND}
	app-arch/bzip2
	app-arch/gzip
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	local myconf

	use oss || myconf="--disable-oss"

	use esd || myconf="${myconf} --disable-esd"

	use nls || myconf="${myconf} --disable-nls"

	use alsa || myconf="${myconf} --disable-alsa"

	use gnome || myconf="${myconf} --disable-gnome"

	econf ${myconf} || die
	emake || die

}

src_install () {

	einstall || die

	# strip suid from binary
	chmod -s ${D}/usr/bin/soundtracker

	# documentation
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
	dodoc doc/*.txt
	dohtml -r doc

}
