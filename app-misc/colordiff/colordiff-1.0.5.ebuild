# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colordiff/colordiff-1.0.5.ebuild,v 1.1 2005/03/29 13:42:20 ka0ttic Exp $

DESCRIPTION="Colorizes output of diff"
HOMEPAGE="http://colordiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/colordiff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~mips ~sparc ~amd64 ~ppc64 ~ppc ~ppc-macos"
IUSE=""

DEPEND="sys-apps/diffutils"

src_compile() {
:
}

src_install() {
	newbin colordiff.pl colordiff || die
	newbin cdiff.sh cdiff || die
	insinto /etc
	doins colordiffrc colordiffrc-lightbg
	fowners root:root /etc/colordiffrc /etc/colordiffrc-lightbg
	fperms 644 /etc/colordiffrc /etc/colordiffrc-lightbg
	dodoc BUGS CHANGES README TODO
	doman colordiff.1
}
