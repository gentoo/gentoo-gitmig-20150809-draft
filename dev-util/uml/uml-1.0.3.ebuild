# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Holger Brueckner <darks@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/uml/uml-1.0.3.ebuild,v 1.2 2002/05/21 18:14:08 danarmak Exp $

inherit kde-base
 
DESCRIPTION="KDE 2.2 UML Drawing Utility"
SRC_URI="http://prdownloads.sourceforge.net/uml/${P}-1.tar.gz"
HOMEPAGE="http://uml.sourceforge.net"

newdepend ">=kde-base/kdebase-2.2 virtual/glibc"

need-kde 2.2

src_compile() {
	kde_src_compile myconf
	myconf="$myconf --mandir=${D}/usr/share/man"
	kde_src_compile configure make
}

