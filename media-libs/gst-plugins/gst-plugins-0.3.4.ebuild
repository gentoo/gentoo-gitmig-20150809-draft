# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Artem Baguinski <artm@v2.nl>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.3.4.ebuild,v 1.2 2002/04/27 23:08:36 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Additional plugins for gstreamer - streaming media framework"
SRC_URI="http://prdownloads.sourceforge.net/gstreamer/${P}.tar.gz"
HOMEPAGE="http://gstreamer.sourceforge.net"

# required packages
# there are many many optional libraries. features are compiled if the libraries
# are present. most optional libraries are from gnome.
DEPEND=">=media-libs/gstreamer-0.3.4"

src_compile() {
	libtoolize --copy --force
	./configure \
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
