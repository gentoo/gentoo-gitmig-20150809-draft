# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/hashalot/hashalot-0.3.ebuild,v 1.2 2004/06/13 00:24:25 dragonheart Exp $

DESCRIPTION="CryptoAPI utils"
HOMEPAGE="http://www.kerneli.org/"
SRC_URI="http://www.paranoiacs.org/~sluskyb/hacks/hashalot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~alpha ~arm ~ia64 ~amd64"
IUSE=""
RDEPEND="virtual/glibc"

DEPEND="sys-apps/gawk
	sys-apps/grep
	virtual/glibc
	sys-devel/gcc"


src_test() {
	cd ${S}
	make check-TESTS
}

src_install() {
	emake DESTDIR=${D} install || die "install error"
}

