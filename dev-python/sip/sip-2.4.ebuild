# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-2.4.ebuild,v 1.7 2002/08/16 02:49:58 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="http://www.river-bank.demon.co.uk/software/${P}.tar.gz"
HOMEPAGE="http://www.thekompany.com/projects/pykde/"
SLOT="0"
KEYWORDS="x86 sparc sparc64"
LICENSE="MIT"

DEPEND="virtual/python"

src_compile(){
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS COPYING NEWS README THANKS TODO
}
