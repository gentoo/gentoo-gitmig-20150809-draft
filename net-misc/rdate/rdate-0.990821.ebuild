# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-0.990821.ebuild,v 1.2 2004/09/07 19:15:41 robbat2 Exp $

IUSE=""
DESCRIPTION="use TCP or UDP to retrieve the current time of another machine"
HOMEPAGE="http://www.freshmeat.net/projects/rdate/"
MY_P=${P/0.}
S="${WORKDIR}/${MY_P}"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/network/misc/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=""

src_compile() {
	make || die
}

src_install() {
	dodir /usr/bin /usr/share /usr/share/man/man1
	make DESTDIR=${D} install || die
	dodoc README.linux
}
