# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcfldd/dcfldd-1.2.2.ebuild,v 1.2 2005/06/22 22:11:14 vapier Exp $

DESCRIPTION="enhanced dd with features for forensics and security"
HOMEPAGE="http://dcfldd.sourceforge.net/"
SRC_URI="mirror://sourceforge/dcfldd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '1i#include <sys/mount.h>' \
		sizeprobe.c
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
