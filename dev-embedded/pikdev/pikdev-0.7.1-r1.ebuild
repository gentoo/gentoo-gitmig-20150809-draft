# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.7.1-r1.ebuild,v 1.1 2004/11/30 23:37:53 robbat2 Exp $

inherit kde
need-kde 3

DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
# restrict at Authors request
RESTRICT="nomirror"

RDEPEND="${RDEPEND}
	dev-embedded/gputils"
DEPEND="${DEPEND} ${RDEPEND}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-fix.diff
}

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
	einfo "The author requests that you email him at alain.gibaud@free.fr when you"
	einfo "install this package. See http://pikdev.free.fr/download.php3 for details"

	ewarn "CAUTION: If you already have a previous version of PiKdev, do not forget to delete the"
	ewarn " ~/.kde/share/apps/pikdev directory before running the new version. This directory"
	ewarn " contains a local copy of configuration files and prevents new functionnalities to appear"
	ewarn " in menus/toolbars."
}
