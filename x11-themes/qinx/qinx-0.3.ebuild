# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qinx/qinx-0.3.ebuild,v 1.2 2002/10/22 15:45:01 bjb Exp $
inherit kde-base

need-kde 3

DESCRIPTION="Qinx, a KDE style inspired by QNX Photon microGUI"
SRC_URI="http://www.usermode.org/code/${P}.tar.gz"
HOMEPAGE="http://www.usermode.org/code.html"
LICENSE="as-is"

KEYWORDS="x86 alpha"

newdepend ">=kde-base/kdebase-3.0"
