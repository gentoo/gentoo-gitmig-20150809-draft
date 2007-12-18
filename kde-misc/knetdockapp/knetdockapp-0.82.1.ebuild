# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/knetdockapp/knetdockapp-0.82.1.ebuild,v 1.1 2007/12/18 07:00:05 philantrop Exp $

inherit kde

DESCRIPTION="Network interface monitor panel applet"
HOMEPAGE="http://pan4os.info"
SRC_URI="http://pan4os.info/apps/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.5
