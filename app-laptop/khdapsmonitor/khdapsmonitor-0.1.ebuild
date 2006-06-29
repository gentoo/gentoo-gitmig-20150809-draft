# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/khdapsmonitor/khdapsmonitor-0.1.ebuild,v 1.1 2006/06/29 22:56:09 uberlord Exp $

inherit kde

DESCRIPTION="KDE monitor for the Hard Drive Active Protection System"
HOMEPAGE="http://roy.marples.name/node/269"
SRC_URI="http://roy.marples.name/files/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"

need-kde 3.5
