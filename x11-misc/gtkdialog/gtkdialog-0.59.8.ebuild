# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdialog/gtkdialog-0.59.8.ebuild,v 1.1 2005/08/20 23:52:38 smithj Exp $

DESCRIPTION="GUI-creation utility that can be used with an arbitrary interpreter"
HOMEPAGE="http://linux.pte.hu/~pipas/gtkdialog/"
SRC_URI="ftp://linux.pte.hu/pub/gtkdialog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

DEPEND="=x11-libs/gtk+-2*"

src_install(){
	einstall || die "einstall failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	if use doc; then
		mkdir -p ${D}/usr/share/${P} && cp -r examples/* ${D}/usr/share/${P}
	fi
}


