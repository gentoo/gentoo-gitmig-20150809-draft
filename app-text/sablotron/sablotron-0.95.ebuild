# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.95.ebuild,v 1.2 2002/08/16 02:42:02 murphy Exp $

MY_P="Sablot-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${MY_P}.tar.gz"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=sys-devel/gcc-2.95.2 
		>=dev-libs/expat-1.95.1 
		virtual/glibc"


src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall prefix=${D}/usr || die
	dodoc README* RELEASE
	dodoc src/TODO
}
