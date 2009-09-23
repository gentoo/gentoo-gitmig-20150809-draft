# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cunit/cunit-1.0.0.8.ebuild,v 1.6 2009/09/23 17:42:09 patrick Exp $

S=${WORKDIR}/CUnit-1.0-8
DESCRIPTION="CUnit - C Unit Test Framework"
# Note: Upstream authors have sucky versioning scheme. We fake.
SRC_URI="mirror://sourceforge/cunit/CUnit-1.0-8.tar.gz"
HOMEPAGE="http://cunit.sourceforge.net"

DEPEND=""

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc"
IUSE=""

src_compile() {
	./configure --prefix=/usr || die "configure failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
