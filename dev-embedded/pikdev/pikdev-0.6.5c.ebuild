# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.6.5c.ebuild,v 1.1 2004/04/08 22:46:33 dragonheart Exp $


inherit kde
need-kde 3

DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${P}.tar.gz"

# restrict at Authors request
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="	x11-libs/qt
		x11-base/xfree
		sys-libs/zlib
		dev-libs/expat
		sys-devel/gcc
		media-libs/fontconfig
		media-libs/freetype
		media-libs/jpeg
		media-libs/libart_lgpl
		media-libs/libmng
		media-libs/libpng
		media-libs/nas
		sys-devel/gcc
		dev-embedded/gputils
		app-admin/fam
		virtual/glibc"

# build system uses some perl
DEPEND="${RDEPEND}
		dev-lang/perl
		>=sys-devel/gcc-3.0.0
		>=sys-apps/sed-4"

S=${WORKDIR}/${P}

src_compile() {
	kde_src_compile myconf configure
	sed -i -e "s#\(kde_.* = \)\${prefix}\(.*\)#\1${KDEDIR}\2#g" Makefile */Makefile
	kde_src_compile make
}

pkg_postinst() {

	einfo "The author request you email alain.gibaud@free.fr when you install this program. See the"
	einfo "http://pikdev.free.fr/download.php3 for details"

	ewarn "CAUTION: If you already have a previous version of PiKdev, do not forget to delete the"
	ewarn " ~/.kde/share/apps/pikdev directory before installing the new version. This directory"
	ewarn " contains a local copy of configuration files and prevents new functionnalities to appear"
	ewarn " in menus/toolbars."
}

