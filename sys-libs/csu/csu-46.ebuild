# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/csu/csu-46.ebuild,v 1.1 2004/11/15 06:39:41 kito Exp $

DESCRIPTION="Darwin Csu"
HOMEPAGE="http://darwinsource.opendarwin.org/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/Csu-${PV}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE=""

DEPEND="sys-devel/cctools-extras
		virtual/libc"

src_compile() {
	emake INDR=/usr/bin/indr || die "make failed"
}

src_install() {
	dolib {bundle1.o,crt0.o,crt1.o,dylib1.o,gcrt0.o,gcrt1.o,pscrt0.o,pscrt1.o} \
	|| die "install libs failed"
}