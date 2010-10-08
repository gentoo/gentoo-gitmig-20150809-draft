# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mon/mon-0.99.2-r2.ebuild,v 1.5 2010/10/08 00:06:41 cla Exp $

inherit toolchain-funcs

DESCRIPTION="highly configurable service monitoring daemon"
HOMEPAGE="http://www.kernel.org/software/mon/"
SRC_URI="mirror://kernel/software/admin/mon/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND=">=dev-perl/Mon-0.9
	>=virtual/perl-Time-HiRes-1.20
	>=dev-perl/Period-1.20-r2"

RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}"/mon.d
	make CC="$(tc-getCC) $CFLAGS" || die
}

src_install() {
	dosbin mon clients/mon* || die "dosbin"

	insinto /usr/lib/mon/utils
	doins utils/* || die "doins"

	exeinto /usr/lib/mon/alert.d ; doexe alert.d/*
	exeinto /usr/lib/mon/mon.d ; doexe mon.d/*.monitor
	insopts -g uucp -m 02555 ; doins mon.d/*.wrap

	dodir /var/log/mon.d
	dodir /var/lib/mon.d

	doman doc/*.1
	doman doc/*.8
	dodoc CHANGES CREDITS KNOWN-PROBLEMS
	dodoc mon.lsm README TODO VERSION
	docinto txt ; dodoc doc/README*
	docinto etc ; dodoc etc/*
	newdoc "${FILESDIR}"/mon.cf mon.cf.sample

	newinitd "${FILESDIR}"/mon.rc6 mon
	insinto /etc/mon
	newins "${FILESDIR}"/mon.cf mon.cf.sample
}
