# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.1.0.ebuild,v 1.2 2002/08/16 04:13:59 murphy Exp $

S=${WORKDIR}/${P}

DESCRIPTION="The GNOME Structured File Library"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
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

	if [ "`use gnome`" ]
	then
		# README lied it is --with-gnomevfs not --with-gnome-vfs
		# building with-gnomevfs fails, disabling it
		# stroke@gentoo.org
		#
		#myconf="--with-gnomevfs --with-bonobo"
		myconf="--without-gnomevfs --with-bonobo"
	else
		myconf="--without-gnomevfs --without-bonobo"
	fi

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
