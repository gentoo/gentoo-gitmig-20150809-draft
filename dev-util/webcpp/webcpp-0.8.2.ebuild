# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/webcpp/webcpp-0.8.2.ebuild,v 1.5 2006/05/01 01:58:52 weeve Exp $

inherit toolchain-funcs

IUSE=""

S=${WORKDIR}/${P}-src
DESCRIPTION="converts source code into HTML file using a customizable syntax highlighting engine and colour schemes"
HOMEPAGE="http://webcpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/webcpp/${P}-src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~hppa ~mips ppc sparc x86"

RDEPEND="sys-devel/gcc
	virtual/libc"

pkg_setup() {
	[ `gcc-major-version` -eq 2 ] \
		&& die "WebCPP only works with gcc-3.x" \
		|| return 0
}

src_install() {
	einstall || die
	dodoc AUTHORS CREDITS ChangeLog README TODO
}
