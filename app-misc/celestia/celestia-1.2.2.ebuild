# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/celestia/celestia-1.2.2.ebuild,v 1.1 2002/04/13 10:37:40 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a free replacement for Tripwire"
SRC_URI="http://prdownloads.sourceforge.net/celestia/${P}.tar.gz"
HOMEPAGE="http://www.shatters.net/celestia"
SLOT="0"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* =x11-libs/gtkglarea-1.2* )
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

