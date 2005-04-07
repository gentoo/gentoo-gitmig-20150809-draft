# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/paxtest/paxtest-0.9.6.ebuild,v 1.8 2005/04/07 23:59:37 solar Exp $

inherit eutils

DESCRIPTION="PaX regression test suite"
HOMEPAGE="http://www.adamantix.org/paxtest/"
SRC_URI="http://www.adamantix.org/paxtest/paxtest-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ppc64 ~sparc x86"
IUSE=""
# pax flags are not strip safe.
RESTRICT="nostrip"

DEPEND="virtual/libc
	>=sys-apps/chpax-0.5"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/Makefile-portable ${S}/Makefile
}

src_compile() {
	emake DESTDIR=${D} BINDIR=${D}/usr/bin RUNDIR=/usr/lib/paxtest || die
}

src_install() {
	make DESTDIR="${D}" BINDIR=/usr/bin RUNDIR=/usr/lib/paxtest install || die
	for doc in Changelog README ;do
		[[ -f ${doc} ]] && dodoc ${doc}
	done
}
