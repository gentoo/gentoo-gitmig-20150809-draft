# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundtracker/soundtracker-0.6.4.ebuild,v 1.1 2001/09/22 06:35:42 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SoundTracker is a music tracking tool for UNIX/X11 (MOD tracker)"
SRC_URI="http://www.soundtracker.org/dl/v0.6/soundtracker-0.6.4.tar.gz"
HOMEPAGE="http://www.soundtracker.org"

DEPEND=">=x11-libs/gtk+-1.2.2 >=media-libs/audiofile-0.2.1 \
	alsa? ( media-libs/alsa-lib ) \
	esd? ( media-sound/esound ) \
	gnome? ( gnome-base/gnome-core ) \
	sys-libs/zlib"

RDEPEND="$DEPEND sys-apps/bzip2 sys-apps/gzip app-arch/unzip"

src_compile() {
	
	local myconf

	if [ -z "`use oss`" ] ; then
		myconf="--disable-oss"
    fi

	if [ -z "`use alsa`" ] ; then
		myconf="$myconf --disable-alsa"
	fi

	if [ -z "`use esd`" ] ; then
		myconf="$myconf --disable-esd"
    fi

	if [ -z "`use gnome`" ] ; then
		myconf="$myconf --disable-gnome"
	fi

	if [ -z "`use nls`" ] ; then
		myconf="$myconf --disable-nls"
    fi

	try ./configure ${myconf} --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr/X11R6 --host=${CHOST} || die

	emake || die

}

src_install () {
	
	make prefix=${D}/usr/X11R6 install || die

	# strip suid from binary
	chmod -s ${D}/usr/X11R6/bin/soundtracker

	# documentation
	dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README TODO
	dodoc doc/*.txt doc/hacking.html

}

