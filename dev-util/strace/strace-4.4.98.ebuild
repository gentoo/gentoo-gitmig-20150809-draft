# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.4.98.ebuild,v 1.13 2004/06/05 14:53:59 tuxus Exp $

inherit flag-o-matic

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="http://www.wi.leidenuniv.nl/~wichert/strace/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha hppa -mips amd64 ia64"
IUSE="static"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.54"

src_compile() {
	# Compile fails with -O3 on sparc but works on x86
	if [ "${ARCH}" == "sparc" -o "${ARCH}" == "" ]; then
		replace-flags -O[3-9] -O2
	fi
	# configure is broken by default for sparc and possibly others, regen
	# from configure.in
	autoconf
	if use static; then
		LDFLAGS="-static" ./configure --prefix=/usr || die
	else
		./configure --prefix=/usr || die
	fi
	emake || die
}

src_install() {
	# Can't use make install because it is stupid and
	# doesn't make leading directories before trying to
	# install. Thus, one would have to make /usr/bin
	# and /usr/man/man1 (at least).
	# So, we do it by hand.
	doman strace.1
	dobin strace
	dobin strace-graph
	dodoc ChangeLog COPYRIGHT CREDITS NEWS PORTING README* TODO
}
