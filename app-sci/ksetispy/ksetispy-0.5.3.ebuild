# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksetispy/ksetispy-0.5.3.ebuild,v 1.5 2004/06/29 11:48:24 carlo Exp $

inherit kde

DESCRIPTION="Monitors the progess of the SETI@home client, using the same interface as SETI Spy for Windows"
HOMEPAGE="http://ksetispy.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=kde-base/kdelibs-3
	app-sci/setiathome"
need-kde 3
