# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/rudiments/rudiments-0.25.1.ebuild,v 1.2 2004/03/14 02:22:37 mr_bones_ Exp $

# Contributed by: Karl Haines <karl420@comcast.net>

DESCRIPTION="Rudiments is an Open Source C++ class library providing base classes for things such as daemons, clients and servers, and wrapper classes for the standard C functions for things like such as regular expressions, semaphores and signal handling."
HOMEPAGE="http://rudiments.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/rudiments/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-gnu-ld \
		--mandir=/usr/share/man || die "./configure failed"
	make CXXFLAGS="${CFLAGS}" || die
}

src_install() {
	einstall || die
}
