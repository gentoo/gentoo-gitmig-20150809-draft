# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nvi/nvi-1.81.4.ebuild,v 1.18 2005/02/10 15:03:29 ciaranm Exp $

DESCRIPTION="Vi clone"
SRC_URI="http://www.kotnet.org/~skimo/nvi/devel/${P}.tar.gz"
HOMEPAGE="http://www.bostic.com/vi/"

SLOT="0"
LICENSE="Sleepycat"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=sys-libs/db-3.1"
RDEPEND="${DEPEND} !app-editors/vim"

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
