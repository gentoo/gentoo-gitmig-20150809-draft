# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colordiff/colordiff-1.0.5-r1.ebuild,v 1.1 2005/07/11 03:35:57 agriffis Exp $

DESCRIPTION="Colorizes output of diff"
HOMEPAGE="http://colordiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/colordiff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/diffutils"

src_compile() {
	# By default colordiff-1.0.5 lowercases config values, so we need to
	# lowercase OFF in the executable as well
	sed -i -e 's/\<OFF\>/off/g' colordiff.pl
	sed -i -e 's/^plain=.*/plain=off/' colordiffrc*
}

src_install() {
	newbin colordiff.pl colordiff cdiff.sh cdiff || die
	insinto /etc
	doins colordiffrc colordiffrc-lightbg
	dodoc BUGS CHANGES README TODO
	doman colordiff.1
}
