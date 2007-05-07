# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdiff3/kdiff3-0.9.92.ebuild,v 1.4 2007/05/07 15:26:05 armin76 Exp $

inherit kde

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="sys-apps/diffutils"

need-kde 3.5

pkg_preinst(){
	kde_pkg_preinst
	dodir /usr/share/applications/kde/
	mv ${D}/usr/share/applnk/Development/kdiff3.desktop ${D}/usr/share/applications/kde/
}
