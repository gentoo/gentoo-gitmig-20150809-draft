# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kflog/kflog-2.1.1-r1.ebuild,v 1.1 2005/08/25 05:04:51 smithj Exp $

inherit kde

DESCRIPTION="A flight logger/analyser for KDE aimed at glider pilots"
HOMEPAGE="http://www.kflog.org/kflog/"
SRC_URI="http://www.kflog.org/download/src/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/gawk
	sys-devel/gettext
	sys-apps/grep
	sys-devel/gcc
	virtual/libc
	sys-libs/zlib
	arts? ( kde-base/arts )"

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
	=x11-libs/qt-3*"

need-kde 3

src_unpack() {
	unpack ${A}
	if ! use arts; then
		einfo "Removing arts checks..."
		cd ${S}
		sed -i -e '488,489d' -e '508,509d' acinclude.m4
		einfo "Running autotools..."
		aclocal
		automake
		autoconf
		einfo "Fixing all Makefile.in..."
		perl admin/am_edit \
			po/Makefile.in \
			doc/en/Makefile.in \
			doc/Makefile.in \
			kflog/pics/Makefile.in \
			kflog/map-icons/small/Makefile.in \
			kflog/map-icons/Makefile.in \
			kflog/Makefile.in \
			kflog/guicontrols/Makefile.in \
			kflog/kfrfil/Makefile.in \
			kflog/kfrgcs/Makefile.in \
			kflog/kfrgmn/Makefile.in \
			kflog/kfrxcu/Makefile.in \
			kflog/kfrxsp/Makefile.in \
			Makefile.in
	fi
}

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
