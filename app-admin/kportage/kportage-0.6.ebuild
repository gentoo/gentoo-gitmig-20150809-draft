# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kportage/kportage-0.6.ebuild,v 1.3 2003/02/13 05:25:37 vapier Exp $

inherit kde-base

need-kde 3
need-qt 3.1

DESCRIPTION="A graphical frontend for portage"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.freesoftware.fsf.org/kportage/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

newdepend ">=sys-apps/portage-2.0.45
	~dev-lang/python-2.2.2"

IUSE=""

src_compile() {
	kde_src_compile myconf configure
	emake CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" || die
}
