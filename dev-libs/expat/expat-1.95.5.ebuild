# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.5.ebuild,v 1.4 2002/12/15 10:44:12 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XML parsing libraries"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"
HOMEPAGE="http://expat.sourceforge.net"
DEPEND="virtual/glibc"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_compile() {
	econf 
	# parallel make doesnt work
	make || die
}

src_install() {
	einstall
	dodoc COPYING Changes MANIFEST README
	dohtml doc/*
}
