# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksetispy/ksetispy-0.5.2.ebuild,v 1.6 2004/06/24 22:05:33 agriffis Exp $

inherit kde-base
need-kde 3

IUSE=""
KEYWORDS="x86"
DESCRIPTION="Monitors the progess of the SETI@home client, using the same interface as SETI Spy for Windows"

HOMEPAGE="http://ksetispy.sourceforge.net"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
newdepend "app-sci/setiathome"

