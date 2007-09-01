# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/away/away-0.9.5.ebuild,v 1.10 2007/09/01 15:58:30 angelos Exp $

DESCRIPTION="Terminal locking program with few additional features"
HOMEPAGE="http://unbeatenpath.net/software/away/"
SRC_URI="http://unbeatenpath.net/software/away/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=">=sys-libs/pam-0.75"

src_unpack() {
	unpack ${A}
	sed -i "s:-O2:${CFLAGS}:" ${S}/Makefile
}
src_compile() {
	emake || die
}

src_install() {
	dobin away || die
	insinto /etc/pam.d ; newins data/away.pam away
	doman doc/*
	dodoc BUGS AUTHORS NEWS README TODO data/awayrc
}
