# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colordiff/colordiff-1.0.4.ebuild,v 1.15 2004/10/27 19:27:14 kito Exp $

DESCRIPTION="Colorizes output of diff"
HOMEPAGE="http://colordiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/colordiff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ~mips sparc ~amd64 ppc64 ppc ~ppc-macos"
IUSE=""

DEPEND="sys-apps/diffutils"

src_compile() {
:
}

src_install() {
	newbin colordiff.pl colordiff || die
	insinto /etc
	doins colordiffrc colordiffrc-lightbg
	fowners root:root /etc/colordiffrc /etc/colordiffrc-lightbg
	fperms 644 /etc/colordiffrc /etc/colordiffrc-lightbg
	dodoc BUGS CHANGES README TODO
	doman colordiff.1
}
