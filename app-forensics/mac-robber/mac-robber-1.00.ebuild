# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/mac-robber/mac-robber-1.00.ebuild,v 1.5 2009/09/13 22:34:40 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="mac-robber is a digital forensics and incident response tool that collects data"
HOMEPAGE="http://www.sleuthkit.org/mac-robber/index.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)" GCC_OPT="${CFLAGS}" \
		|| die "make failed"
}

src_test() {
	./mac-robber -V || die "test failed"
}

src_install() {
	dobin mac-robber
	dodoc README
}
