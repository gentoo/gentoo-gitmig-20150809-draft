# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-1.100.ebuild,v 1.1 2002/05/30 01:38:28 spider Exp $


# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="gthumb is an Image Viewer and Browser for Gnome."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gthumb.sourceforge.net/"
LICENSE="GPL-2"


RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.3
	>=dev-libs/libxml2-2.4.22
	>=gnome-base/libgnome-1.117.2
	>=gnome-base/libgnomeui-1.117.2
	>=gnome-base/libgnomecanvas-1.117.0
	>=gnome-base/gnome-vfs-1.9.16
	>=gnome-base/libglade-1.99.12-r2
	>=gnome-extra/libgnomeprint-1.114.0
	>=gnome-extra/libgnomeprintui-1.114.0
	>=gnome-base/bonobo-activation-0.9.9
	>=gnome-base/libbonobo-1.117.1
	>=gnome-base/libbonoboui-1.117.1
	>=media-libs/libpng-1.2.1"


DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib || die

	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
	install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	doman ${S}/doc/gthumb.1 
}
