# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.7.1-r2.ebuild,v 1.3 2006/10/22 14:04:49 peper Exp $

inherit kde

DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
# restrict at Authors request
# RESTRICT="nomirror"
# but he has since stopped hosting it, it's on the gentoo mirrors now

DEPEND="dev-embedded/gputils"
need-kde 3

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-fix.diff
	epatch ${FILESDIR}/${P}-configure-arts.patch
}

src_compile() {
	KDEDIR=$(kde-config --prefix)
	kde_src_compile myconf configure
	sed -i -e "s#\(kde_.* = \)\${prefix}\(.*\)#\1${KDEDIR}\2#g" Makefile */Makefile
	kde_src_compile make
}

src_install() {
	kde_src_install all
	dobin pkp
}

pkg_postinst() {
	einfo "The author requests that you email him at alain.gibaud@free.fr when you"
	einfo "install this package. See http://pikdev.free.fr/download.php3 for details"

	ewarn "CAUTION: If you already have a previous version of PiKdev, do not forget to delete the"
	ewarn " ~/.kde/share/apps/pikdev directory before running the new version. This directory"
	ewarn " contains a local copy of configuration files and prevents new functionnalities to appear"
	ewarn " in menus/toolbars."
}
