# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nvi/nvi-1.81.4.ebuild,v 1.16 2004/06/24 22:00:29 agriffis Exp $

DESCRIPTION="Vi clone"
SRC_URI="http://www.kotnet.org/~skimo/nvi/devel/${P}.tar.gz"
HOMEPAGE="http://www.bostic.com/vi/"

SLOT="0"
LICENSE="Sleepycat"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=sys-libs/db-3.1"

PROVIDE="virtual/editor"

src_compile() {
	cd build.unix
	../dist/configure \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST} || die
	emake || die
}

src_install() {
	cd ${S}/build.unix
	einstall
}
