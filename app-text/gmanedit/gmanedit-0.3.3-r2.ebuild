# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Tools Team <tools@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-text/gmanedit/gmanedit-0.3.3-r2.ebuild,v 1.1 2002/04/30 08:29:28 seemant Exp $

S=${WORKDIR}/${P}.orig
DESCRIPTION="Gnome based manpage editor"
SRC_URI="http://gmanedit.sourceforge.net/files/${P}.tar.bz2"
HOMEPAGE="http://gmanedit.sourceforge.net/"

DEPEND="virtual/x11
	>=gnome-base/gnome-libs-1.4.1.4"

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"
	
	econf ${myconf} || die

	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog TODO README NEWS
}
