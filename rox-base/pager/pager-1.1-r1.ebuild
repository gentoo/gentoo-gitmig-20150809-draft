# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/pager/pager-1.1-r1.ebuild,v 1.1 2007/02/09 17:31:44 lack Exp $

ROX_CLIB_VER=2.1.7
inherit rox eutils

DESCRIPTION="Pager - A pager applet for ROX-Filer"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/libwnck-2.4.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20"

APPNAME=Pager
APPNAME_COLLISION=True

