# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-3.0.ebuild,v 1.2 2002/02/17 18:56:03 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="http://www.river-bank.demon.co.uk/software/${P}.tar.gz"
HOMEPAGE="http://www.thekompany.com/projects/pykde/"

DEPEND="virtual/glibc
	virtual/python"

src_compile(){
	./configure --prefix=/usr --with-qt-dir=/usr/qt/3 || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS COPYING NEWS README THANKS TODO
}
