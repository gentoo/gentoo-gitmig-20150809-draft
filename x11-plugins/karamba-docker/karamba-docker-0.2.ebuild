# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-docker/karamba-docker-0.2.ebuild,v 1.1 2003/05/04 06:47:43 prez Exp $

DESCRIPTION="Docking menu plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5960"
SRC_URI="http://www.kdelook.org/content/files/5960-docker.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-misc/superkaramba-0.21"

src_unpack () {
	unpack ${A}
	mv docker ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/docker
	cp *.py ${D}/usr/share/karamba/themes/docker
	sed -e 's#/home/genneth/src/docker/#/usr/share/karamba/themes/docker/#' \
		docker.py > ${D}/usr/share/karamba/themes/docker/docker.py
	cp docker.theme ${D}/usr/share/karamba/themes/docker
	cp -r AppLnk ${D}/usr/share/karamba/themes/docker
	cp -r Pics ${D}/usr/share/karamba/themes/docker
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/docker

	dodoc README COPYING
}
