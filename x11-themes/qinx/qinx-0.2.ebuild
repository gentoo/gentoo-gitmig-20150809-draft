# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: #
inherit kde-base

need-kde 3

DESCRIPTION="Qinx, a KDE style inspired by QNX Photon microGUI"
SRC_URI="http://www.usermode.org/code/qinx-0.2.tar.gz"
HOMEPAGE="http://www.usermode.org/code.html"
LICENSE="as-is"

KEYWORDS="x86"

newdepend ">=kde-base/kdebase-3.0"
