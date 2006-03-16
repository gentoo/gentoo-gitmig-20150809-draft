# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kxmleditor/kxmleditor-1.1.4.ebuild,v 1.7 2006/03/16 23:36:10 flameeyes Exp $

inherit kde

DESCRIPTION="KDE XML Editor to display and edit contents of XML files"
HOMEPAGE="http://kxmleditor.sourceforge.net"
SRC_URI="mirror://sourceforge/kxmleditor/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64 sparc"
IUSE=""

need-kde 3.1

src_install() {
	kde_src_install

	dodir /usr/share/applications/kde
	mv ${D}/usr/share/applnk/Applications/kxmleditor.desktop \
		${D}/usr/share/applications/kde
}

