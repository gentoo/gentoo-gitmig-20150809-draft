# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-0.8.2.ebuild,v 1.2 2003/07/06 00:06:56 liquidx Exp $

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"
SRC_URI="mirror://sourceforge/meld/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=dev-python/gnome-python-1.99.15
	>=dev-python/pygtk-1.99.15
	>=dev-python/orbit-python-1.99.0"

src_unpack(){
    unpack ${A} ; cd ${S}
    epatch ${FILESDIR}/${P}-gentoo.diff
} 

src_install() {
	insinto /usr/lib/meld
	doins *.py 
	dobin meld
	insinto /usr/share/meld/glade2
	doins glade2/*
	insinto /usr/share/meld/glade2/pixmaps
	doins glade2/pixmaps/*
	insinto /usr/share/applications
	doins meld.desktop
	dodoc AUTHORS COPYING INSTALL TODO.txt
	dohtml manual/*
}
