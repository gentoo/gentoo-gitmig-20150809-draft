# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rpc2/rpc2-1.13.ebuild,v 1.7 2003/12/26 13:11:49 weeve Exp $

DESCRIPTION="Remote procedure call package for IP/UDP (used by Coda)"
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/rpc2/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="x86 ~sparc "
SLOT="1"

# partly based on the deps suggested by Mandrake's RPM
DEPEND="virtual/glibc
	>=sys-libs/lwp-1.9
	>=sys-libs/ncurses-5
	>=sys-libs/readline-4.1"

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
