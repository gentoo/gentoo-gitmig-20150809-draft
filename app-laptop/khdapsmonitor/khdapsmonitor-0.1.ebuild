# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/khdapsmonitor/khdapsmonitor-0.1.ebuild,v 1.2 2008/11/22 18:08:23 maekke Exp $

inherit kde

DESCRIPTION="KDE monitor for the Hard Drive Active Protection System"
HOMEPAGE="http://roy.marples.name/node/269"
SRC_URI="http://roy.marples.name/files/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

need-kde 3.5
