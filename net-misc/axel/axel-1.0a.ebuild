# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/axel/axel-1.0a.ebuild,v 1.19 2005/02/18 00:37:53 mr_bones_ Exp $

DESCRIPTION="light Unix download accelerator"
HOMEPAGE="http://www.lintux.cx/axel.html"
SRC_URI="http://www.lintux.cx/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ppc-macos sparc x86"
IUSE="debug"

DEPEND="virtual/libc"

src_compile() {
	local myconf

	use debug && myconf="--debug=1 --strip=0"
	econf \
		--etcdir=/etc \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc API CHANGES CREDITS README axelrc.example
}
