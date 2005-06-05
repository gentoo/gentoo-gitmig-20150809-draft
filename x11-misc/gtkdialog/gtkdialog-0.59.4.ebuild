# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdialog/gtkdialog-0.59.4.ebuild,v 1.1 2005/06/05 12:20:33 pyrania Exp $

DESCRIPTION="GUI-creation utility that can be used with an arbitrary interpreter"
HOMEPAGE="http://freshmeat.net/projects/gtkdialog/"
SRC_URI="ftp://linux.pte.hu/pub/gtkdialog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND="=x11-libs/gtk+-2*"

src_install(){
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	if use doc; then
		mkdir -p ${D}/usr/share/${P} && cp -r examples/* ${D}/usr/share/${P}
	fi
}


