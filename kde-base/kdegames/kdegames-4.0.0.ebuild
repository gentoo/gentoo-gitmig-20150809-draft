# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-4.0.0.ebuild,v 1.1 2008/01/17 23:47:38 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE games module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"  
LICENSE="GPL-2 LGPL-2"

RESTRICT="test"

PATCHES="${FILESDIR}/lskat-4.0.0-link.patch"
