# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/celestia/celestia-1.2.2.ebuild,v 1.5 2002/07/11 06:30:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Celestia is a free real-time space simulation that lets you experience our universe in three dimensions"
SRC_URI="mirror://sourceforge/celestia/${P}.tar.gz"
HOMEPAGE="http://www.shatters.net/celestia"
SLOT="0"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* <x11-libs/gtkglarea-1.99.0 )
	gnome? ( =gnome-base/gnome-libs-1.4* )
	virtual/glu >=media-libs/glut-3.7-r2
	media-libs/jpeg >=media-libs/libpng-1.2.1"

src_compile() {

	local myconf

	# currently celestia's "gtk support" requires gnome
	use gtk || myconf="--without-gtk"
	use gnome || myconf="--without-gtk"

	./configure --prefix=/usr ${myconf} || die

	emake all || die

}

src_install() {

	make install prefix=${D}/usr

	dodoc AUTHORS COPYING NEWS README TODO controls.txt
	dohtml manual/*.html manual/*.css

}

