# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/baghira/baghira-0.6d.ebuild,v 1.4 2005/03/21 08:25:29 voxus Exp $

inherit kde

DESCRIPTION="Baghira - an OS-X like style for KDE"
HOMEPAGE="http://baghira.sourceforge.net/"
SRC_URI="mirror://sourceforge/baghira/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.3 )"

need-kde 3.3

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-compile-fix.patch || die
}
