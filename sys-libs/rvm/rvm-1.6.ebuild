# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/rvm/rvm-1.6.ebuild,v 1.6 2003/06/22 05:10:31 seemant Exp $

DESCRIPTION="Recoverable Virtual Memory (used by Coda)"
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/rvm/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=sys-libs/lwp-1.9"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
