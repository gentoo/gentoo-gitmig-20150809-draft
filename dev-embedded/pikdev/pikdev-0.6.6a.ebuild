# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.6.6a.ebuild,v 1.2 2004/07/18 06:36:47 dragonheart Exp $

inherit kde

DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
# restrict at Authors request
RESTRICT="nomirror"

# need-kde adds kde-libs,qt,.. rdependencies 
# why this lengthy list?
# A. overzealous
RDEPEND="sys-libs/zlib
	dev-libs/expat
	sys-devel/gcc
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg
	media-libs/libart_lgpl
	media-libs/libmng
	media-libs/libpng
	sys-devel/gcc
	dev-embedded/gputils
	app-admin/fam
	virtual/libc"

# Ebuild will evily link to these if present
#	media-libs/nas

DEPEND="${RDEPEND}"

need-kde 3

src_compile() {
	kde_src_compile myconf configure
	sed -i -e "s#\(kde_.* = \)\${prefix}\(.*\)#\1${KDEDIR}\2#g" Makefile */Makefile
	kde_src_compile make
}

src_install() {
	kde_src_install all
	dobin pkp
}

pkg_postinst() {
	einfo "The author request you email alain.gibaud@free.fr when you install this program. See the"
	einfo "http://pikdev.free.fr/download.php3 for details"

	ewarn "CAUTION: If you already have a previous version of PiKdev, do not forget to delete the"
	ewarn " ~/.kde/share/apps/pikdev directory before installing the new version. This directory"
	ewarn " contains a local copy of configuration files and prevents new functionnalities to appear"
	ewarn " in menus/toolbars."
}
