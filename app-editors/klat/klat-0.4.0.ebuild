# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/klat/klat-0.4.0.ebuild,v 1.1 2002/10/25 20:44:33 satai Exp $
inherit kde-base

need-kde 3

DESCRIPTION="A Latex Editor and TeX shell for KDE 3"
SRC_URI="http://lumumba.luc.ac.be/jori/klat/${P}.tar.bz2"
HOMEPAGE="http://lumumba.luc.ac.be/jori/klat/klat.html"
DEPEND="app-text/tetex"
IUSE=""
KEYWORDS="~x86 ~sparc ~sparc64"
LICENSE="GPL-2"

src_install() {

    einstall || die

}
