# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.3.0.ebuild,v 1.4 2002/10/05 05:39:14 drobbins Exp $

IUSE="gnome"

S=${WORKDIR}/${P}

DESCRIPTION="The GNOME Structured File Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/libgsf/libgsf-1.3.0.tar.bz2 mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4.23
	>=sys-libs/zlib-1.1.4
	gnome? ( >=gnome-base/libbonobo-2.0.0
		>=gnome-base/gnome-vfs-2.0.1 )" 

RDEPEND="${DEPEND}"

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
