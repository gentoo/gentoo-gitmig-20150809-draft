# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-disk/karamba-disk-0.17.ebuild,v 1.5 2004/03/26 23:10:06 aliz Exp $

IUSE=""
DESCRIPTION="Disk Usage plugin for Karamba"
HOMEPAGE="http://www.efd.lth.se/~d98hk/karamba/"
SRC_URI="http://www.efd.lth.se/~d98hk/karamba/karamba_disk.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

RDEPEND="|| ( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv karamba_disk ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/disk
	cp -r * ${D}/usr/share/karamba/themes/disk/
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/disk
}
