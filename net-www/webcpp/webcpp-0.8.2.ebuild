# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/webcpp/webcpp-0.8.2.ebuild,v 1.1 2003/07/02 17:49:13 vapier Exp $

inherit gcc

IUSE=""

S=${WORKDIR}/${P}-src
DESCRIPTION="converts source code into HTML file using a customizable syntax highlighting engine and colour schemes"
HOMEPAGE="http://webcpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/webcpp/${P}-src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

RDEPEND="sys-devel/gcc
	virtual/glibc"

pkg_setup() {
	[ `gcc-major-version` -eq 2 ] \
		&& die "WebCPP only works with gcc-3.x" \
		|| return 0
}

src_compile() {
	econf --with-gnu-ld || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS CREDITS ChangeLog README TODO
}
