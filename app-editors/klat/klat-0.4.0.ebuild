# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/klat/klat-0.4.0.ebuild,v 1.3 2002/12/09 04:17:39 manson Exp $

inherit kde-base

need-kde 3

DESCRIPTION="A Latex Editor and TeX shell for KDE 3"
SRC_URI="http://lumumba.luc.ac.be/jori/klat/${P}.tar.bz2"
HOMEPAGE="http://lumumba.luc.ac.be/jori/klat/klat.html"

KEYWORDS="~x86 ~sparc "
LICENSE="GPL-2"

DEPEND="app-text/tetex"

src_install() {
	einstall
}
