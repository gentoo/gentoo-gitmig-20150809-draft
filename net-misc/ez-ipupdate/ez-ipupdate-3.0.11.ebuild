# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ez-ipupdate/ez-ipupdate-3.0.11.ebuild,v 1.1 2002/01/14 19:09:11 verwilst Exp $

S="${WORKDIR}/${P}b6"
SRC_URI="http://gusnet.cx/proj/ez-ipupdate/dist/${P}b6.tar.gz"
HOMEPAGE="http://gusnet.cx/proj/ez-ipupdate"
DESCRIPTION="Dynamic DNS client for lots of dynamic dns services"

DEPEND="virtual/glibc"

src_compile() {

	cd ${S}
	./configure --host=${CHOST} --prefix=/usr || die	
	emake || die
}

src_install(){

	make DESTDIR=${D} install || die

}
