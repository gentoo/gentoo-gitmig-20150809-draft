# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Artem Baguinski <artm@v2.nl>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.3.4.ebuild,v 1.5 2002/07/03 16:25:02 phoenix Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Additional plugins for gstreamer - streaming media framework"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.gz"
HOMEPAGE="http://gstreamer.sourceforge.net"

# required packages
# there are many many optional libraries. features are compiled if the libraries
# are present. most optional libraries are from gnome.
DEPEND=">=media-libs/gstreamer-0.3.4
	media-sound/mad
	oggvorbis? ( 	media-libs/libvorbis 
					media-libs/libogg )
	media-sound/lame
	jpeg? (	media-libs/jpeg )
	esd? ( media-sound/esound )
	gnome? ( >=gnome-base/gnome-vfs-2.0.1 )
	mikmod? ( media-libs/libmikmod )"
RDEPEND="${DEPEND}"

src_compile() {
	libtoolize --copy --force
	./configure \
		--disable-avifile \
		--disable-dv \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL README RELEASE TODO 
}

pkg_postinst () {
	gst-register
}
