# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.4.1-r1.ebuild,v 1.1 2001/09/22 13:58:45 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-python"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/latest/sources/"${A}
HOMEPAGE="http://www.gnome.org"

DEPEND="virtual/python
	>=x11-libs/gtk+-1.2.6
	>=media-libs/imlib-1.8.10
	gnome? ( >=gnome-base/gnome-core-1.4.0 )
        opengl? ( >=x11-libs/gtkglarea-1.2.2 )"

src_compile() {

	if [ -n "`use gnome`" ]
	then
		PYTHON="/usr/bin/python" ./configure --host=${CHOST} 	\
					     	     --prefix=/usr 	\
						     ${myopts} || die
		make || die
	else
		cd ${S}/pygtk
		PYTHON="/usr/bin/python" ./configure --host=${CHOST} 	\
						     --prefix=/usr 	\
						     ${myopts} || die
		make || die
	fi
}

src_install() {

	if [ -n "`use gnome`" ]
	then
		cd ${S}/pygnome
		make prefix=${D}/usr install || die

		dodoc AUTHORS COPYING* ChangeLog NEWS MAPPING
		dodoc README*

		cd ${S}/pygnome
		docinto pygnome
		dodoc COPYING
	else
		cd ${S}/pygtk
		make prefix=${D}/usr install || die
	fi

	cd ${S}/pygtk
	docinto pygtk
	dodoc AUTHORS COPYING ChangeLog NEWS MAPPING README
}



