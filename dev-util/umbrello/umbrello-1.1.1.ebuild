# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/umbrello/umbrello-1.1.1.ebuild,v 1.4 2003/12/28 04:08:18 caleb Exp $
inherit kde

# This project was formerly known as simply 'uml', and there were ebuilds under dev-util/uml
# it is also included in kdesdk-3.2.*

DESCRIPTION="KDE UML Drawing Utility"
SRC_URI="mirror://sourceforge/uml/${P}.tar.bz2"
HOMEPAGE="http://uml.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=kde-base/kdebase-3
	sys-devel/flex"

