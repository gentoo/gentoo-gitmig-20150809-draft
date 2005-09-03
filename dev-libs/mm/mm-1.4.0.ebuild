# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.4.0.ebuild,v 1.1 2005/09/03 12:07:46 dragonheart Exp $

inherit libtool

DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.ossp.org/pkg/lib/mm/"
SRC_URI="ftp://ftp.ossp.org/pkg/lib/mm/${P}.tar.gz"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_test() {
	make test || die "testing problem"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README ChangeLog INSTALL PORTING THANKS
}
