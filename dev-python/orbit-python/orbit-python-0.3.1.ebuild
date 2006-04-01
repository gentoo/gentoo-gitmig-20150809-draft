# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/orbit-python/orbit-python-0.3.1.ebuild,v 1.19 2006/04/01 15:12:06 agriffis Exp $

DESCRIPTION="ORBit bindings for Python"
SRC_URI="http://orbit-python.sault.org/files/${P}.tar.gz"
HOMEPAGE="http://orbit-python.sault.org/"

DEPEND="=dev-libs/glib-1.2*
	=gnome-base/orbit-0*
	virtual/python"

SLOT="0"
KEYWORDS="alpha ~ia64 ~ppc sparc x86"
IUSE=""
LICENSE="GPL-2"

src_compile() {
	CFLAGS="$CFLAGS `gnome-config --cflags libIDL`"

	PYTHON="/usr/bin/python" ./configure --host=${CHOST} 		\
				   	     --prefix=/usr 		\
					     --with-libIDL-prefix=/usr 	\
					     --with-orbit-prefix=/usr
	assert

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
