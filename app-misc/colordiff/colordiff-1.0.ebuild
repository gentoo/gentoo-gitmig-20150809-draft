# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colordiff/colordiff-1.0.ebuild,v 1.7 2003/08/06 07:53:37 vapier Exp $

DESCRIPTION="Colorizes output of diff"
HOMEPAGE="http://colordiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/colordiff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="sys-apps/diffutils"

src_install() {
	newbin colordiff.pl colordiff
	insinto /etc
	doins colordiffrc
	chown root.root ${S}/etc/colordiffrc
	chmod 644 ${S}/etc/colordiffrc
	dodoc BUGS CHANGES COPYING README TODO
}
