# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksetiwatch/ksetiwatch-2.6.0.ebuild,v 1.2 2003/07/02 12:33:39 aliz Exp $

inherit kde-base
need-kde 3

KEYWORDS="x86 ~ppc"
IUSE=""
DESCRIPTION="A monitoring tool for SETI@home, similar to SETIWatch for Windows"
HOMEPAGE="http://ksetiwatch.sourceforge.net"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
newdepend "app-sci/setiathome"

