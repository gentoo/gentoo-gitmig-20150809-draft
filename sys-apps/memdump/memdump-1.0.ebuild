# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memdump/memdump-1.0.ebuild,v 1.2 2004/08/30 16:28:08 dholm Exp $

DESCRIPTION="Simple memory dumper for UNIX-Like systems"
HOMEPAGE="http://www.porcupine.org/forensics"
SRC_URI="http://www.porcupine.org/forensics/${P}.tar.gz"
LICENSE="IBM"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND="sys-apps/sed
	sys-apps/grep"
RDEPEND="virtual/libc"
IUSE=""

src_compile() {
	emake XFLAGS="${CFLAGS}" OPT= DEBUG= || die
}

src_test() {
	if has userpriv ${FEATURES};
	then
		einfo "Cannot test with FEATURES=userpriv"
	else
		./memdump -s 30 || die "failed test"
	fi
}

src_install() {
	into /usr
	dosbin memdump
	dodoc README LICENSE
	doman memdump.1
}
