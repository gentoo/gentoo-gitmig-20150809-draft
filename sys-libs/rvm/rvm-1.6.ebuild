# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/rvm/rvm-1.6.ebuild,v 1.10 2004/07/02 08:51:03 eradicator Exp $

DESCRIPTION="Recoverable Virtual Memory (used by Coda)"
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/rvm/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86"

DEPEND="virtual/libc
	>=sys-libs/lwp-1.9"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
