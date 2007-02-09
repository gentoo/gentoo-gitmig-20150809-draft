# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/pager/pager-1.0.1-r1.ebuild,v 1.1 2007/02/09 17:31:44 lack Exp $

inherit rox eutils

PAGER_PATCH_FN="01_all_libwnck-2-fix.patch"
DESCRIPTION="Pager - A pager applet for ROX-Filer"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-libs/libwnck-2.4.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20"

APPNAME=Pager
APPNAME_COLLISION=True

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/${P}/${APPNAME}/src
	epatch "${FILESDIR}"/${PAGER_PATCH_FN}
}
