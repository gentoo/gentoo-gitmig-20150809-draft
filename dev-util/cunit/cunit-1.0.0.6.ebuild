# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Yannick Koehler <ykoehler@hotmail.com>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cunit/cunit-1.0.0.6.ebuild,v 1.1 2002/04/13 21:29:31 karltk Exp $

S=${WORKDIR}/CUnit-1.0-6
DESCRIPTION="CUnit - C Unit Test Framework"
# Note: Upstream authors have sucky versioning scheme. We fake.
SRC_URI="http://prdownloads.sourceforge.net/cunit/CUnit-1.0-6.tar.gz"
HOMEPAGE="http://cunit.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
