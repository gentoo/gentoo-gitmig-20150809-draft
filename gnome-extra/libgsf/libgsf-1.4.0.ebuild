# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.4.0.ebuild,v 1.2 2003/02/13 12:22:47 vapier Exp $

inherit gnome.org

S=${WORKDIR}/${P}

DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4.23
	>=sys-libs/zlib-1.1.4
	gnome? ( >=gnome-base/libbonobo-2.0.0
		>=gnome-base/gnome-vfs-2.0.1 )" 


src_compile() {
	local myconf 

	use gnome &&  myconf="--with-gnome" || myconf="--without-gnome"
	econf $myconf --with-zlib  || die
	make || die
}

src_install() {

	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		datadir=${D}/usr/share \
		install || die

	dodoc AUTHORS COPYING* ChangeLog INSTALL NEWS README
}

