# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="Colorizes output of diff"
SRC_URI="http://colordiff.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://colordiff.sourceforge.net/"
IUSE=""

DEPEND="sys-apps/diffutils"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~sparc64"

src_install () {

	exeinto /usr/bin
	newexe ${S}/colordiff.pl colordiff
	insinto /etc
	doins ${S}/colordiffrc
	chown root.root ${S}/etc/colordiffrc
	chmod 644 ${S}/etc/colordiffrc
	dodoc BUGS CHANGES COPYING README TODO
}
