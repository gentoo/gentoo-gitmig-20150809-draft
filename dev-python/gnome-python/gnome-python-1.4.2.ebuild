# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.4.2.ebuild,v 1.18 2005/03/23 14:27:19 liquidx Exp $

IUSE="gnome opengl"

DESCRIPTION="gnome-python"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/latest/sources/${P}.tar.gz"
HOMEPAGE="http://www.pygtk.org/"

DEPEND="virtual/python
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
		 <gnome-base/libglade-1.90.0
		 <gnome-base/control-center-1.90.0 )
	opengl? ( <x11-libs/gtkglarea-1.99.0 )"

SLOT="1"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2"

src_compile() {
	if use gnome
	then
		CFLAGS="${CFLAGS} `gnome-config capplet --cflags`" \
		econf ${myopts} || die
	else
		cd ${S}/pygtk
		econf ${myopts} || die
	fi
	make || die
}

src_install() {

	if use gnome
	then
		cd ${S}/pygnome
		make prefix=${D}/usr datadir=${D}/usr/share install || die

		dodoc AUTHORS COPYING* ChangeLog NEWS MAPPING
		dodoc README*

		cd ${S}/pygnome
		docinto pygnome
		dodoc COPYING
	fi

	cd ${S}/pygtk
	make prefix=${D}/usr datadir=${D}/usr/share install || die

	cd ${S}/pygtk
	docinto pygtk
	dodoc AUTHORS COPYING ChangeLog NEWS MAPPING README
}
