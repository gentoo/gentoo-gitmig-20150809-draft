# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-smbwho/karamba-smbwho-0.1.ebuild,v 1.4 2003/05/04 03:23:36 prez Exp $

DESCRIPTION="Samba status plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5698"
SRC_URI="http://www.kdelook.org/content/files/5698-smbwho-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="|| ( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv smbwho ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/bin /usr/share/karamba/themes
	cp smbwho.py ${D}/usr/share/karamba/bin
	chmod 755 ${D}/usr/share/karamba/bin/smbwho.py

	dodir /usr/share/karamba/themes/smbwho
	cp -r smbstats.theme ${D}/usr/share/karamba/themes/smbwho/smbwho.theme
	cp -r pics ${D}/usr/share/karamba/themes/smbwho
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/smbwho

	dodoc README
}
