# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/pager/pager-1.0.0.ebuild,v 1.1 2004/11/27 10:14:50 sergey Exp $

DESCRIPTION="Pager - A pager applet for ROX-Filer"

HOMEPAGE="http://rox.sourceforge.net/"

SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

ROX_LIB_VER=1.9.14

APPNAME=Pager

DEPEND=">=x11-libs/libwnck-2.4.0"

inherit rox
