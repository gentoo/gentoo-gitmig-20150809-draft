# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/abs-guide/abs-guide-2.4.ebuild,v 1.1 2004/01/26 06:35:53 mr_bones_ Exp $

DESCRIPTION="An advanced reference and a tutorial on bash shell scripting"
SRC_URI="http://personal.riverusers.com/~thegrendel/${P}.tar.bz2"
HOMEPAGE="http://www.tldp.org/LDP/abs/html"
S="${WORKDIR}"

KEYWORDS="x86 sparc ppc alpha arm hppa"
LICENSE="FDL-1.1"
SLOT="0"

src_install() {
	dodir "/usr/share/doc/${P}"       || die "dodir failed"
	cp -R * "${D}/usr/share/doc/${P}" || die "cp failed"
}
