# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/abs-guide/abs-guide-1.8.ebuild,v 1.1 2003/05/23 13:28:15 joker Exp $

DESCRIPTION="An advanced  reference and a tutorial on bash shell scripting."
SRC_URI="http://personal.riverusers.com/~thegrendel/${P}.tar.bz2"
HOMEPAGE="http://www.tldp.org/LDP/abs/html"
S=${WORKDIR}

SLOT="0"
LICENSE="FDL-1.1"
KEYWORDS="x86 sparc ppc alpha arm hppa"

src_install() {
   dodir /usr/share/doc/abs-guide
   cp -R * ${D}/usr/share/doc/abs-guide
}
