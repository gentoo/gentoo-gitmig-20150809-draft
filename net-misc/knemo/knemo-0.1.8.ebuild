# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knemo/knemo-0.1.8.ebuild,v 1.1 2004/06/28 16:30:37 carlo Exp $

inherit kde

DESCRIPTION="KNemo - the KDE Network Monitor"
SRC_URI="http://kde-apps.org/content/files/12956-${P}.tar.bz2"
HOMEPAGE="http://kde-apps.org/content/show.php?content=12956"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

need-kde 3.2