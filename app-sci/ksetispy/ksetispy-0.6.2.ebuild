# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksetispy/ksetispy-0.6.2.ebuild,v 1.1 2004/07/26 17:21:02 pbienst Exp $

inherit kde

DESCRIPTION="Monitors the progess of the SETI@home client, using the same interface as SETI Spy for Windows"
HOMEPAGE="http://ksetispy.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=kde-base/kdelibs-3
	app-sci/setiathome"
need-kde 3
