# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <alkaline@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/vlock/vlock-1.3.ebuild,v 1.1 2001/08/05 19:01:52 pete Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A console screen locker"

SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/console/vlock-1.3.tar.gz"
HOMEPAGE="http://"
DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	try make RPM_OPT_FLAGS="${CFLAGS}"
}

src_install () {
	cd ${S}
	dobin vlock
	doman vlock.1
	dodoc COPYING README
}

