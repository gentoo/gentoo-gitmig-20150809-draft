# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/klogview/klogview-0.6.ebuild,v 1.4 2005/07/22 09:24:29 dholm Exp $

inherit kde

DESCRIPTION="A KDE utility for viewing log files in real time."
HOMEPAGE="http://klogview.sourceforge.net"
SRC_URI="mirror://sourceforge/klogview/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~sparc x86"
IUSE=""

need-kde 3
