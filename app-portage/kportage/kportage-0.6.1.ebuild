# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kportage/kportage-0.6.1.ebuild,v 1.5 2004/06/29 18:09:09 mr_bones_ Exp $

inherit kde

DESCRIPTION="A graphical frontend for portage"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${PN}.pkg/${PV/.1//}/${P}.tar.bz2"
HOMEPAGE="http://www.freesoftware.fsf.org/kportage/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=sys-apps/portage-2.0.46-r12
	>=dev-lang/python-2.2.2
	>=x11-libs/qt-3.1"
need-kde 3

src_compile() {
	kde_src_compile myconf configure
	emake CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" || die
}
