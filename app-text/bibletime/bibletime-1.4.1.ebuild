# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.4.1.ebuild,v 1.1 2004/04/08 22:20:25 squinky86 Exp $

inherit kde
need-kde 3

IUSE=""
DESCRIPTION="BibleTime KDE Bible study application using the SWORD library."
HOMEPAGE="http://bibletime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
newdepend ">=app-text/sword-1.5.7
	>=net-misc/curl-7.10"
