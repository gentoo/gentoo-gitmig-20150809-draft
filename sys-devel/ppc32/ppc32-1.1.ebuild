# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ppc32/ppc32-1.1.ebuild,v 1.1 2005/07/06 04:39:46 dostrow Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A PPC32 compilation environment."
HOMEPAGE="http://dev.gentoo.org/~dostrow/ppc32"
SRC_URI="mirror://gentoo.org/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install () {
	dobin ppc32
	dosym ppc32 /usr/bin/ppc64
	dosym ppc32 /usr/bin/linux32
	dosym ppc32 /usr/bin/linux64
	doman ppc32.8
	dosym ppc32.8.gz /usr/share/man/man8/linux32.8.gz
	doman ppc64.8
	dosym ppc64.8.gz /usr/share/man/man8/linux64.8.gz
}
