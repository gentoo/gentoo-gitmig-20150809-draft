# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rpc2/rpc2-1.13.ebuild,v 1.12 2005/02/05 14:34:53 griffon26 Exp $

DESCRIPTION="Remote procedure call package for IP/UDP (used by Coda)"
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/rpc2/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="x86 ~sparc "
IUSE=""
SLOT="1"

# partly based on the deps suggested by Mandrake's RPM
DEPEND="virtual/libc
	>=sys-libs/lwp-1.9
	>=sys-libs/ncurses-5
	>=sys-libs/readline-4.1"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
