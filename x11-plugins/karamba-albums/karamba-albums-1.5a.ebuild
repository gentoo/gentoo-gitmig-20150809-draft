# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-albums/karamba-albums-1.5a.ebuild,v 1.1 2003/05/04 05:16:27 prez Exp $

DESCRIPTION="BOFH bar plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5692"
SRC_URI="http://www.kdelook.org/content/files/5692-albums_${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="|| ( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv albums_1.5a ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/albums

	mv pictures.pl pictures.pl~
	sed -e 's#/usr/mark/karamba.themes/#/usr/share/karamba/themes/albums/#' \
		pictures.pl~ >pictures.pl

	sed -e 's#pictures.pl#~/.karamba/pictures.pl#g' \
		-e 's#mailcheck.pl#~/.karamba/mailcheck.pl#g' \
		albums.theme > ${D}/usr/share/karamba/themes/albums/albums.theme
	sed -e 's#pictures.pl#~/.karamba/pictures.pl#g' \
		-e 's#mailcheck.pl#~/.karamba/mailcheck.pl#g' \
		albumsclock.theme > ${D}/usr/share/karamba/themes/albums/albumsclock.theme
	sed -e 's#pictures.pl#~/.karamba/pictures.pl#g' \
		-e 's#mailcheck.pl#~/.karamba/mailcheck.pl#g' \
		albumsmail.theme > ${D}/usr/share/karamba/themes/albums/albumsmail.theme
	cp -r pics ${D}/usr/share/karamba/themes/albums
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/albums

	dodoc pictures.pl mailcheck.pl
}
