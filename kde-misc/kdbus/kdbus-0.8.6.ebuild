# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdbus/kdbus-0.8.6.ebuild,v 1.7 2007/07/08 05:55:24 mr_bones_ Exp $

inherit kde

DESCRIPTION="D-BUS service browser for KDE."
SRC_URI="http://rohanpm.net/files/${P}.tar.gz"
HOMEPAGE="http://rohanpm.net/kdbus"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="( || ( dev-libs/dbus-qt3-old
	>=sys-apps/dbus-0.34 ) )"
RDEPEND="${DEPEND}"

need-kde 3.3

PATCHES="${FILESDIR}/${P}-desktop.patch"
