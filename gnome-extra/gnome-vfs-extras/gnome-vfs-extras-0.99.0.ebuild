# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-extras/gnome-vfs-extras-0.99.0.ebuild,v 1.1 2002/05/22 22:40:44 spider Exp $


# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="the Gnome Virtual Filesystem extra libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="GPL-2"


RDEPEND=">=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.8-r1
	>=gnome-base/ORBit2-2.3.106
	>=gnome-base/gnome-mime-data-1.0.6
	>=gnome-base/gnome-vfs-1.9.10
	>=sys-devel/gettext-0.10.40"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.12.0"
	

src_compile() {
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS  README
}





