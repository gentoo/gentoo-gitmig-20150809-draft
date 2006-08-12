# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mon/mon-0.99.2-r4.ebuild,v 1.1 2006/08/12 12:32:30 mcummings Exp $

inherit toolchain-funcs eutils multilib

DESCRIPTION="highly configurable service monitoring daemon"
HOMEPAGE="http://www.kernel.org/software/mon/"
SRC_URI="mirror://kernel/software/admin/mon/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ldap mysql"

DEPEND=">=dev-perl/Mon-0.9
	>=virtual/perl-Time-HiRes-1.20
	dev-perl/Convert-BER
	dev-perl/Filesys-DiskSpace
	dev-perl/Net-Telnet
	ldap? ( dev-perl/perl-ldap )
	dev-perl/Expect
	dev-perl/Net-DNS
	mysql? ( dev-perl/DBD-mysql )
	>=dev-perl/Period-1.20-r2"

src_unpack() {
	unpack ${A}
	cd ${S} && epatch ${FILESDIR}/alertafter.patch
}

src_compile() {
	cd ${S}/mon.d
	make CC="$(tc-getCC) $CFLAGS" || die
}

src_install() {
	dosbin mon clients/mon* || die "dosbin"

	insinto /usr/$(get_libdir)/mon/utils
	doins utils/* || die "doins"

	exeinto /usr/$(get_libdir)/mon/alert.d ; doexe alert.d/*
	exeinto /usr/$(get_libdir)/mon/mon.d ; doexe mon.d/*.monitor
	insopts -g uucp -m 02555 ; doins mon.d/*.wrap

	dodir /var/log/mon.d
	dodir /var/lib/mon.d

	doman doc/*.1
	doman doc/*.8
	dodoc CHANGES CREDITS KNOWN-PROBLEMS
	dodoc mon.lsm README TODO VERSION
	docinto txt ; dodoc doc/README*
	docinto etc ; dodoc etc/*
	newdoc ${FILESDIR}/mon.cf mon.cf.sample

	exeinto /etc/init.d
	newexe ${FILESDIR}/mon.rc6 mon
	insinto /etc/mon
	newins ${FILESDIR}/mon.cf mon.cf.sample
}
