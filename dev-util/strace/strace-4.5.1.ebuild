# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.5.1.ebuild,v 1.16 2004/11/22 02:21:52 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="http://www.wi.leidenuniv.nl/~wichert/strace/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/libc
	>=sys-devel/autoconf-2.54"

src_compile() {
	# Compile fails with -O3 on sparc but works on x86
	if [ "${ARCH}" == "sparc" -o "${ARCH}" == "" ]; then
		replace-flags -O[3-9] -O2
	fi
	filter-lfs-flags

	epatch ${FILESDIR}/${P}-2.6.patch

	# configure is broken by default for sparc and possibly others, regen
	# from configure.in
	autoconf
	./configure --prefix=/usr || die "configure died"
	emake || die "make failed"
}

src_install() {
	# Can't use make install because it is stupid and
	# doesn't make leading directories before trying to
	# install. Thus, one would have to make /usr/bin
	# and /usr/man/man1 (at least).
	# So, we do it by hand.
	doman strace.1
	dobin strace strace-graph || die
	dodoc ChangeLog CREDITS NEWS PORTING README* TODO
}
