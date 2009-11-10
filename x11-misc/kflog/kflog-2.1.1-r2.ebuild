# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kflog/kflog-2.1.1-r2.ebuild,v 1.4 2009/11/10 22:52:37 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="A flight logger/analyser for KDE aimed at glider pilots"
HOMEPAGE="http://www.kflog.org/kflog/"
SRC_URI="http://www.kflog.org/download/src/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ppc ~sparc x86"
IUSE=""

need-kde 3.5

src_install() {
	kde_src_install
	rm -rf "${D}"/usr/share/doc/HTML
	chown -R root:users "${D}"/usr/share/apps/kflog/mapdata
	chmod -R ug+rw "${D}"/usr/share/apps/kflog/mapdata
}

pkg_postinst() {
	elog "Note: Maps are not included. KFlog can download required data"
	elog "for you, or you may obtain map/airspace/airfield data at:"
	elog
	elog "http://maproom.kflog.org/"
	elog
	elog "and untar them in /usr/share/apps/kflog/mapdata"
	elog "Visiting http://www.kflog.org/ is generally a good idea."
}

pkg_postrm() {
	elog "Note: If you installed any maps, airspace or airfield data -"
	elog "DO NOT FORGET to remove it manually! (/usr/share/apps/kflog/mapdata"
	elog
	elog "Browsing though /usr/share/apps/kflog might be a good idea."
}
