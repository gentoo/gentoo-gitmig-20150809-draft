# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/umbrello/umbrello-1.1.1.ebuild,v 1.6 2004/01/29 03:14:12 brad_mssw Exp $
inherit kde

# This project was formerly known as simply 'uml', and there were ebuilds under dev-util/uml
# it is also included in kdesdk-3.2.*

DESCRIPTION="KDE UML Drawing Utility"
SRC_URI="mirror://sourceforge/uml/${P}.tar.bz2"
HOMEPAGE="http://uml.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86 amd64"

#do our own dependencies
NEED_KDE_DONT_ADD_KDELIBS_DEP=1

need-kde 3

DEPEND=">=kde-base/kdebase-3
	sys-devel/flex"

