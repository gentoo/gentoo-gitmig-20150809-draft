# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.3.4.ebuild,v 1.8 2002/08/14 13:08:09 murphy Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Additional plugins for gstreamer - streaming media framework"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.gz"
HOMEPAGE="http://gstreamer.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

# required packages
# there are many many optional libraries. features are compiled if the libraries
# are present. most optional libraries are from gnome.
DEPEND=">=media-libs/gstreamer-0.3.4
	media-sound/mad
	media-sound/lame
	esd? ( media-sound/esound )
	jpeg? (	media-libs/jpeg )
	gnome? ( >=gnome-base/gnome-vfs-2.0.1 )
	mikmod? ( media-libs/libmikmod )
	oggvorbis? ( media-libs/libvorbis 
		media-libs/libogg )"


src_compile() {

	elibtoolize
	econf \
		--disable-avifile \
		--disable-dv || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL README RELEASE TODO ChangeLog
}

pkg_postinst () {
	gst-register
}
