# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-agenda/karamba-agenda-0.1.ebuild,v 1.5 2003/05/04 03:23:36 prez Exp $

DESCRIPTION="Current Agenda plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5793"
SRC_URI="http://www.kdelook.org/content/files/5793-agenda.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="|| ( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv agenda ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/bin /usr/share/karamba/themes
	sed -e 's#/home/petros/.kde/share/apps/karamba/agenda/agenda.txt#$HOME/.karamba/agenda.txt#' \
		agenda.sh > ${D}/usr/share/karamba/bin/agenda.sh
	chmod 755 ${D}/usr/share/karamba/bin/agenda.sh

	dodir /usr/share/karamba/themes/agenda
	sed -e 's#/home/petros/.kde/share/apps/karamba/agenda/##' agenda.theme \
		> ${D}/usr/share/karamba/themes/agenda/agenda.theme
	cp -r pics ${D}/usr/share/karamba/themes/agenda
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/agenda

	dodoc README
}
