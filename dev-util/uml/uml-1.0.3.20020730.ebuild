# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/uml/uml-1.0.3.20020730.ebuild,v 1.7 2003/02/13 12:02:32 vapier Exp $
inherit kde-base
 
S=${WORKDIR}/${PN}
DESCRIPTION="KDE UML Drawing Utility"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://uml.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86 sparc "

newdepend ">=kde-base/kdebase-3 virtual/glibc"

need-kde 3

