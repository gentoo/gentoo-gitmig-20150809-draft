# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/umbrello/umbrello-1.1.1.ebuild,v 1.8 2004/06/25 02:49:25 agriffis Exp $

inherit kde
need-kde 3

# This project was formerly known as simply 'uml', and there were ebuilds under dev-util/uml
# it is also included in kdesdk-3.2.*

DESCRIPTION="KDE UML Drawing Utility"
SRC_URI="mirror://sourceforge/uml/${P}.tar.bz2"
HOMEPAGE="http://uml.sourceforge.net"

SLOT="0"
IUSE=""

LICENSE="GPL-2"
KEYWORDS="x86 amd64"

#do our own dependencies
NEED_KDE_DONT_ADD_KDELIBS_DEP=1


DEPEND=">=kde-base/kdebase-3
	sys-devel/flex"

