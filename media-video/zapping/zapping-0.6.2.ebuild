# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/zapping/zapping-0.6.2.ebuild,v 1.4 2002/05/27 17:27:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Zapping is a TV- and VBI- viewer for the Gnome environment."
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=gnome-base/libglade-0.17-r1
	=x11-libs/gtk+-1.2*"

src_compile() {
	./configure --prefix=/usr --infodir=/usr/share/info \
	--mandir=/usr/share/man --host=${CHOST} || die

	mv src/Makefile src/Makefile.orig
	sed -e 's/INCLUDES \= \$(COMMON_INCLUDES)/INCLUDES \= \$(COMMON_INCLUDES) -I\/usr\/include\/libglade-1.0 /' src/Makefile.orig >src/Makefile
	emake || die
}

src_install () {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     infodir=${D}/usr/share/info \
	     mandir=${D}/usr/share/man \
		 PACKAGE_LIB_DIR=${D}/usr/lib/zapping \
		 PACKAGE_PIXMAPS_DIR=${D}/usr/share/pixmaps/zapping \
		 PLUGIN_DEFAULT_DIR=${D}/usr/lib/zapping/plugins \
	     install || die
	rm ${D}/usr/bin/zapzilla
	dosym /usr/bin/zapping /usr/bin/zapzilla
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
