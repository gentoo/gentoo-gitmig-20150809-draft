# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.4.0.ebuild,v 1.2 2002/07/22 14:37:06 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Additional plugins for gstreamer - streaming media framework"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.gz"
HOMEPAGE="http://gstreamer.sourceforge.net"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"


# required packages
# there are many many optional libraries. features are compiled if the libraries
# are present. most optional libraries are from gnome.
DEPEND=">=media-libs/gstreamer-0.4.0
	>=gnome-base/gconf-1.2.0
	media-sound/mad
	dvd? (	>=media-libs/libdv-0.9.5 )
	oggvorbis? ( 	media-libs/libvorbis 
					media-libs/libogg )
	media-sound/lame
	media-sound/cdparanoia
	media-libs/flac
	media-sound/jack-audio-connection-kit
	media-libs/hermes
	media-libs/openquicktime
	jpeg? (	media-video/mjpegtools 
		>=media-libs/jpeg-mmx-1.1.2-r1 )
	esd? ( media-sound/esound )
	gnome? ( >=gnome-base/gnome-vfs-2.0.1 )
	mikmod? ( media-libs/libmikmod )
	avi? ( media-video/avifile )
	sdl? ( media-libs/libsdl )
	png? ( >=media-libs/libpng-1.2.3 )
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	arts? ( >=kde-base/arts-1.0.2 )
	aalib? ( media-libs/aalib )
	dvd? ( media-libs/libdvdnav )
	media-libs/ladspa-sdk "
# xmms is off-per-default
#	media-sound/xmms

RDEPEND="${DEPEND}"

src_compile() {
	elibtoolize
	# this is an ugly patch to remove -I/usr/include from some CFLAGS
	patch -p0 <${FILESDIR}/${P}-configure.patch
	local myconf
	# aalib broken, dv on to test
	# dvdnav is broken
	myconf="--enable-dv"
	use avi \
		&& myconf="${myconf} --enable-avifile" \
		|| myconf="${myconf} --disable-avifile"
	# not testing for much here, since if its in USE we want it, but its autodetected by configure
	
	./configure \
		${myconf} \
		--without-vorbis-includes \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--oldincludedir=/usr/include \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"		
	make DESTDIR=${D} install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	
	dodoc AUTHORS COPYING INSTALL README RELEASE TODO 
}

pkg_postinst () {
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	export GCONF_CONFIG_SOURCE=`/usr/bin/gconftool-2 --get-default-source`
	cat ${WORKDIR}/../build-info/CONTENTS | grep "obj /etc/gconf/schemas" | sed 's:obj \([^ ]*\) .*:\1:' |while read F; do
		/usr/bin/gconftool-2  --makefile-install-rule ${F}
	done
	gst-register
}
