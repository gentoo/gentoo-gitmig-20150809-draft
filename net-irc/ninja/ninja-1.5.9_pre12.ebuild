# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ninja/ninja-1.5.9_pre12.ebuild,v 1.3 2004/10/19 12:29:35 absinthe Exp $

S=${WORKDIR}/${P/_*/}

DESCRIPTION="Ninja IRC Client"
HOMEPAGE="http://ninja.qoop.org/"
SRC_URI="ftp://qoop.org/ninja/stable/${P/_/}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~sparc ~ppc"
IUSE="ncurses ipv6 ssl"

DEPEND="virtual/libc
	ncurses? ( sys-libs/ncurses )
	ssl?  ( dev-libs/openssl )"

src_compile() {
	econf $(use_enable ipv6) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
