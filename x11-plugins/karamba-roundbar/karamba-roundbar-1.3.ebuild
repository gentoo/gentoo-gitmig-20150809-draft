# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-roundbar/karamba-roundbar-1.3.ebuild,v 1.1 2003/05/04 04:34:43 prez Exp $

DESCRIPTION="Round menu plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5851"
SRC_URI="http://www.kdelook.org/content/files/5851-RoundBar-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-misc/superkaramba-0.21"

src_unpack () {
	unpack ${A}
	mv RoundBar-${PV} ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/roundbar
	sed -e 's#"/home/lele/.kde/share/apps/karamba/themes/RoundBar-1.2/Files/#os.environ["HOME"] + "/.karamba/#' \
		RoundBar.py > ${D}/usr/share/karamba/themes/roundbar/RoundBar.py
	cp RoundBar.theme ${D}/usr/share/karamba/themes/roundbar
	cp -r Pics ${D}/usr/share/karamba/themes/roundbar
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/roundbar

	dodoc README.txt Files/RoundBar.conf
}
