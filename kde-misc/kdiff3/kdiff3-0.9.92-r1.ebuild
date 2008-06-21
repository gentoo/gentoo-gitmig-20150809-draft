# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdiff3/kdiff3-0.9.92-r1.ebuild,v 1.2 2008/06/21 14:05:05 mr_bones_ Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~ppc64"
IUSE=""

RDEPEND="sys-apps/diffutils"

need-kde 3.5

PATCHES=( "${FILESDIR}/kdiff3-0.9.92-desktop-entry-fix.diff" )

src_compile(){
	rm "${S}"/configure
	kde_src_compile
}
