# Copyright 1999-20022 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.4.1-r3.ebuild,v 1.5 2002/07/27 19:23:31 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gnome-python"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/latest/sources/${P}.tar.gz"
HOMEPAGE="http://www.daa.com.au/~james/gnome/"

DEPEND="virtual/python
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 
	         <gnome-base/libglade-1.90.0 )
	opengl? ( <x11-libs/gtkglarea-1.99.0 )"
RDEPEND="${RDEPEND}"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

src_compile() {

	if [ -n "`use gnome`" ]
	then
		PYTHON="/usr/bin/python" ./configure --host=${CHOST} \
					     	     --prefix=/usr \
		                         ${myopts} || die
		make || die
	else
		cd ${S}/pygtk
		PYTHON="/usr/bin/python" ./configure --host=${CHOST} \
						     --prefix=/usr \
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
	fi

	cd ${S}/pygtk
	make prefix=${D}/usr install || die

	cd ${S}/pygtk
	docinto pygtk
	dodoc AUTHORS COPYING ChangeLog NEWS MAPPING README
}



