# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-0.5.1.ebuild,v 1.10 2004/10/23 23:41:41 weeve Exp $

inherit kde

DESCRIPTION="Personal Finances Manager for KDE"
HOMEPAGE="http://kmymoney2.sourceforge.net"
SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="dev-libs/libxml2
	dev-cpp/libxmlpp"
need-kde 3
