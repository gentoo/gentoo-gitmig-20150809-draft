# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kflog/kflog-2.1.1.ebuild,v 1.10 2005/06/19 20:26:41 smithj Exp $

inherit kde

DESCRIPTION="A flight logger/analyser for KDE aimed at glider pilots"
HOMEPAGE="http://www.kflog.org/kflog/"
SRC_URI="http://www.kflog.org/download/src/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="sys-apps/gawk
	sys-devel/gettext
	sys-apps/grep
	sys-devel/gcc
	virtual/libc
	sys-libs/zlib"

RDEPEND="dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg
	media-libs/libart_lgpl
	media-libs/libmng
	media-libs/libpng
	media-libs/nas
	sys-devel/gcc
	virtual/libc
	sys-libs/zlib
	x11-libs/qt"

need-kde 3

src_install() {
	kde_src_install
	rm -rf ${D}/usr/share/doc/HTML
	chown -R root:users ${D}/usr/share/apps/kflog/mapdata
	chmod -R ug+rw ${D}/usr/share/apps/kflog/mapdata
}

pkg_postinst() {
	einfo "Note: Maps are not included. KFlog can download required data"
	einfo "for you, or you may obtain map/airspace/airfield data at:"
	einfo
	einfo "http://maproom.kflog.org/"
	einfo
	einfo "and untar them in /usr/share/apps/kflog/mapdata"
	einfo "Visiting http://www.kflog.org/ is generally a good idea."
}

pkg_postrm() {
	einfo "Note: If you installed any maps, airspace or airfield data -"
	einfo "DO NOT FORGET to remove it manually! (/usr/share/apps/kflog/mapdata"
	einfo
	einfo "Browsing though /usr/share/apps/kflog might be a good idea."
}
