# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aget/aget-0.4.1.ebuild,v 1.1 2010/08/31 00:11:41 xmw Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="multithreaded HTTP download accelerator"
HOMEPAGE="http://www.enderunix.org/aget/"
SRC_URI="http://www.enderunix.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

src_prepare() {
	sed -i \
		-e '3s/$/DESTDIR =/' \
		-e '/^CFLAGS/s:=.*:+= -Wall $(CPPFLAGS):' \
		-e '/^LDFLAGS/s:=:+=:' \
		-e '/^\tcp -f aget /s:\/usr.*:\$(DESTDIR)\/usr\/bin:' Makefile || die
	sed -i -e '/_XOPEN_SOURCE/d' Head.c || die
	sed -i -e 's/http\/\//http:\/\//' Misc.c || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin aget || die
	dodoc AUTHORS ChangeLog README* THANKS TODO || die
	doman aget.1 || die
}
