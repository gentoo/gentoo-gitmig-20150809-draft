# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-0.9.ebuild,v 1.1 2002/05/28 01:11:32 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="Yelp is a Help browser for Gnome2"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL"

RDEPEND=">=gnome-base/ORBit2-2.3.106
	>=gnome-base/libgnomeui-1.117.2
	>=gnome-base/libgnome-1.117.2
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/libbonobo-1.112.0
	>=gnome-extra/libgtkhtml-1.99.8
	>=dev-libs/libxslt-1.0.15"
	

DEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12.0"

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
    
 	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
