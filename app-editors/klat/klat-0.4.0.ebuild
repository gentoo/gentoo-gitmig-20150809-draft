# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/klat/klat-0.4.0.ebuild,v 1.6 2003/08/05 18:16:24 vapier Exp $

inherit kde-base
need-kde 3

DESCRIPTION="A Latex Editor and TeX shell for KDE 3"
HOMEPAGE="http://lumumba.luc.ac.be/jori/klat/klat.html"
SRC_URI="http://lumumba.luc.ac.be/jori/klat/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

DEPEND="app-text/tetex"

src_install() {
	einstall || die
}
