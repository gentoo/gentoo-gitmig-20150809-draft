# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/uml/uml-1.0.3.20020730.ebuild,v 1.1 2002/07/30 12:27:31 danarmak Exp $
inherit kde-base
 
DESCRIPTION="KDE UML Drawing Utility"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://uml.sourceforge.net"
S=$WORKDIR/uml

newdepend ">=kde-base/kdebase-3 virtual/glibc"

need-kde 3

