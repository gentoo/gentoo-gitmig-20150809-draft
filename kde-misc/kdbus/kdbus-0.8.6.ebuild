# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdbus/kdbus-0.8.6.ebuild,v 1.4 2006/09/29 18:43:12 flameeyes Exp $

inherit kde

DESCRIPTION="D-BUS service browser for KDE."
SRC_URI="http://rohanpm.net/files/${P}.tar.gz"
HOMEPAGE="http://rohanpm.net/kdbus"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="|| ( sys-apps/dbus-core >=sys-apps/dbus-0.50 )"
RDEPEND="${DEPEND}"

need-kde 3.3

PATCHES="${FILESDIR}/${P}-desktop.patch"
