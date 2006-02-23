# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colordiff/colordiff-1.0.3.ebuild,v 1.16 2006/02/23 23:13:04 spyderous Exp $

DESCRIPTION="Colorizes output of diff"
HOMEPAGE="http://colordiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/colordiff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips ~alpha"
IUSE=""

DEPEND="sys-apps/diffutils"

src_install() {
	newbin colordiff.pl colordiff || die
	insinto /etc
	doins colordiffrc
	fowners root:root /etc/colordiffrc
	fperms 644 /etc/colordiffrc
	dodoc BUGS CHANGES README TODO
	doman colordiff.1
}
