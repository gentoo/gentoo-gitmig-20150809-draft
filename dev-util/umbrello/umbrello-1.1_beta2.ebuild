# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/umbrello/umbrello-1.1_beta2.ebuild,v 1.4 2003/09/06 08:39:24 msterret Exp $
inherit kde-base

# This project was formerly known as simply 'uml', and there were ebuilds under dev-util/uml

S=${WORKDIR}/$PN-1.1
DESCRIPTION="KDE UML Drawing Utility"
SRC_URI="mirror://sourceforge/uml/${P//_/-}.tar.bz2"
HOMEPAGE="http://uml.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=kde-base/kdebase-3"

need-kde 3

