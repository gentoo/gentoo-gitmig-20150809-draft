# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mmsclient/mmsclient-0.0.3.ebuild,v 1.8 2004/06/24 23:56:37 agriffis Exp $

S=${WORKDIR}/mms_client-${PV}
DESCRIPTION="mms protocol download utility"
SRC_URI="http://www.geocities.com/majormms/mms_client-${PV}.tar.gz"
HOMEPAGE="http://www.geocities.com/majormms/"
DEPEND="virtual/glibc"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

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
