# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdialog/gtkdialog-0.58.8.ebuild,v 1.2 2004/03/21 15:20:40 dholm Exp $

DESCRIPTION="GUI-creation utility that can be used with an arbitrary interpreter"
HOMEPAGE="http://freshmeat.net/projects/gtkdialog/"
SRC_URI="ftp://linux.pte.hu/pub/gtkdialog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="=x11-libs/gtk+-2*"

src_install(){
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	mkdir -p ${D}/usr/share/${P} && cp -r examples ${D}/usr/share/${P}
}
