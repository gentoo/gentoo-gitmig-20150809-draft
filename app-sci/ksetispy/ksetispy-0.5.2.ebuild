# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksetispy/ksetispy-0.5.2.ebuild,v 1.3 2003/02/13 09:22:47 vapier Exp $

inherit kde-base || die
need-kde 3

IUSE=""
KEYWORDS="x86"
DESCRIPTION="Monitors the progess of the SETI@home client, using the same interface as SETI Spy for Windows"

HOMEPAGE="http://ksetispy.sourceforge.net"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
newdepend "app-sci/setiathome"

