# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/klogview/klogview-0.6.ebuild,v 1.1 2005/02/24 17:38:46 greg_g Exp $

inherit kde

DESCRIPTION="A KDE utility for viewing log files in real time."
HOMEPAGE="http://klogview.sourceforge.net"
SRC_URI="mirror://sourceforge/klogview/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

need-kde 3
