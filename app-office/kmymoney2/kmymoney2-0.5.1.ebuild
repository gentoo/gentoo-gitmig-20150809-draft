# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-0.5.1.ebuild,v 1.1 2003/05/29 03:45:40 caleb Exp $

inherit kde-base
need-kde 3

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="Personal Finances Manager for KDE"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://kmymoney2.sourceforge.net"

newdepend "libxml2 libxml++"

src_unpack() {
	kde_src_unpack
}
