# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/numactl/numactl-1.0.2.ebuild,v 1.1 2008/01/07 03:12:42 vapier Exp $

inherit base eutils toolchain-funcs

DESCRIPTION="Utilities and libraries for NUMA systems."
HOMEPAGE="ftp://ftp.suse.com/pub/people/ak/numa/"
SRC_URI="ftp://ftp.suse.com/pub/people/ak/numa/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	sys-apps/groff"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/numactl-1.0.2-migrate_pages-fix.diff
	sed -i 's:/man2:/man5:' Makefile || die
}

src_compile() {
	emake all html \
		CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake install prefix="${D}/usr" || die
	doman *.8 || die # makefile doesnt get them all
	dodoc README TODO CHANGES DESIGN
	dohtml html/*html
}

src_test() {
	einfo "The only generically safe test is regress2."
	einfo "The other test cases require 2 NUMA nodes."
	cd test
	./regress2 || die "regress2 failed!"
}
