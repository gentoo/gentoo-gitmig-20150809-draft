# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/uml/uml-1.0.3.20020730.ebuild,v 1.5 2002/10/04 05:32:29 vapier Exp $
inherit kde-base
 
S=${WORKDIR}/${PN}
DESCRIPTION="KDE UML Drawing Utility"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://uml.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

newdepend ">=kde-base/kdebase-3 virtual/glibc"

need-kde 3

