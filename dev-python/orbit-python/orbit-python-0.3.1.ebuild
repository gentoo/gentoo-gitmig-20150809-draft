# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/orbit-python/orbit-python-0.3.1.ebuild,v 1.5 2002/08/16 02:49:58 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ORBit bindings for Python"
SRC_URI="http://orbit-python.sault.org/files/${P}.tar.gz"
HOMEPAGE="http://orbit-python.sault.org/"

DEPEND="=dev-libs/glib-1.2*
	>=gnome-base/ORBit-0.5.10-r1
	virtual/python"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 sparc sparc64"
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
