# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pipeworks/pipeworks-0.4.ebuild,v 1.2 2004/03/28 12:06:06 dholm Exp $

DESCRIPTION="a small utility that measures throughput between stdin and stdout"
SRC_URI="mirror://sourceforge/pipeworks/${P}.tar.gz"
HOMEPAGE="http://pipeworks.sourceforge.net/"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RESTRICT="nomirror"
DEPEND="virtual/glibc"


src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin pipeworks || die "dobin failed"
	doman pipeworks.1
	dodoc Changelog README
}
