# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/rvm/rvm-1.6.ebuild,v 1.11 2004/08/12 09:04:04 griffon26 Exp $

DESCRIPTION="Recoverable Virtual Memory (used by Coda)"
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/rvm/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/lwp-1.9"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
