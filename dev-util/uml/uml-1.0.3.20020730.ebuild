# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/uml/uml-1.0.3.20020730.ebuild,v 1.4 2002/08/16 04:04:42 murphy Exp $
inherit kde-base
 
S=${WORKDIR}/${PN}
DESCRIPTION="KDE UML Drawing Utility"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://uml.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

newdepend ">=kde-base/kdebase-3 virtual/glibc"

need-kde 3

