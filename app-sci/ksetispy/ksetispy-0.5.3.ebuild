# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksetispy/ksetispy-0.5.3.ebuild,v 1.1 2004/01/22 03:11:52 caleb Exp $

inherit kde-base
need-kde 3

IUSE=""
KEYWORDS="x86"
DESCRIPTION="Monitors the progess of the SETI@home client, using the same interface as SETI Spy for Windows"

HOMEPAGE="http://ksetispy.sourceforge.net"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
DEPEND=">=kde-base/kdelibs-3
	app-sci/setiathome"

