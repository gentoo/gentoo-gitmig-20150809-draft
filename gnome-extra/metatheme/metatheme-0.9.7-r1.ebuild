# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/metatheme/metatheme-0.9.7-r1.ebuild,v 1.4 2002/09/05 21:27:01 spider Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Theme Selctor utility for Gnome2"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"


RDEPEND=">=dev-libs/glib-2.0.0
	>=x11-libs/pango-1.0.0
	>=x11-libs/gtk+-2.0.0
	>=gnome-base/gconf-1.1.8-r1
	>=gnome-base/libglade-1.99.8-r1
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libgnomecanvas-1.112.1
	>=gnome-base/libbonobo-1.112.0-r1
	>=gnome-base/libbonoboui-1.112.1
	>=gnome-base/libgnomeprintui-1.110.0-r1
	>=gnome-base/ORBit2-2.3.106
	>=sys-devel/gettext-0.10.40"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-platform-gnome-2 \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING README INSTALL NEWS TODO
}





