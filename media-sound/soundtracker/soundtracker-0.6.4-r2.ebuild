# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundtracker/soundtracker-0.6.4-r2.ebuild,v 1.3 2002/07/11 06:30:41 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SoundTracker is a music tracking tool for UNIX/X11 (MOD tracker)"
SRC_URI="http://www.soundtracker.org/dl/v0.6/soundtracker-0.6.4.tar.gz"
HOMEPAGE="http://www.soundtracker.org"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/audiofile-0.2.1 \
	alsa? ( media-libs/alsa-lib ) \
	esd? ( media-sound/esound ) \
	gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 ) \
	sys-libs/zlib"

RDEPEND="$DEPEND sys-apps/bzip2 sys-apps/gzip app-arch/unzip"

src_compile() {
	
	local myconf

	if [ -z "`use oss`" ] ; then
		myconf="--disable-oss"
    fi

	if [ -z "`use alsa`" ] ; then
		myconf="${myconf} --disable-alsa"
	fi

	if [ -z "`use esd`" ] ; then
		myconf="${myconf} --disable-esd"
    fi

	if [ -z "`use gnome`" ] ; then
		myconf="${myconf} --disable-gnome"
	fi

	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
    fi

	./configure	\
		--infodir=/usr/share/info	\
		--mandir=/usr/share/man	\
		--prefix=/usr	\
		--host=${CHOST}	\
		${myconf} || die
		

	emake || die

}

src_install () {
	
	make 	\
		prefix=${D}/usr	\
		install || die

	# strip suid from binary
	chmod -s ${D}/usr/bin/soundtracker

	# documentation
	dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README TODO
	dodoc doc/*.txt
	dohtml -r doc

}

