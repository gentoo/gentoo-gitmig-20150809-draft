# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.7.1-r1.ebuild,v 1.7 2007/01/28 06:16:34 genone Exp $

inherit kde

DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
# we used to restrict at Authors request
# RESTRICT="nomirror"
# but he has since stopped hosting it, it's on the gentoo mirrors now

DEPEND="dev-embedded/gputils
	kde-base/arts"
RDEPEND="${DEPEND}"

need-kde 3

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
	elog "The author requests that you email him at alain.gibaud@free.fr when you"
	elog "install this package. See http://pikdev.free.fr/download.php3 for details"

	ewarn "CAUTION: If you already have a previous version of PiKdev, do not forget to delete the"
	ewarn " ~/.kde/share/apps/pikdev directory before running the new version. This directory"
	ewarn " contains a local copy of configuration files and prevents new functionnalities to appear"
	ewarn " in menus/toolbars."
}
