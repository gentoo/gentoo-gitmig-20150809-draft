# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/mmsclient/mmsclient-0.0.3.ebuild,v 1.1 2002/03/01 21:29:58 chouser Exp $

S=${WORKDIR}/mms_client-${PV}
DESCRIPTION="mms protocol download utility"
SRC_URI="http://www.geocities.com/majormms/mms_client-${PV}.tar.gz"
HOMEPAGE="http://www.geocities.com/majormms/"
DEPEND="virtual/glibc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc COPYING
}
