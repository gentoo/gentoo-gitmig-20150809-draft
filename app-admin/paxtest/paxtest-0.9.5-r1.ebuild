# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/paxtest/paxtest-0.9.5-r1.ebuild,v 1.3 2004/01/11 02:05:58 solar Exp $

# pax flags are not strip safe.
RESTRICT="nostrip"
FEATURES="-distcc"

S=${WORKDIR}/${P}

DESCRIPTION="PaX regression test suite"
SRC_URI="http://pageexec.virtualave.net/paxtest-${PV}.tar.gz"
HOMEPAGE="http://pageexec.virtualave.net"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	>=sys-apps/chpax-0.5"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/paxtest-0.9.5.1.diff
	cp Makefile{,.orig}
	cp Makefile{.Gentoo-hardened,}
}

src_compile() {
	emake DESTDIR=${D} BINDIR=${D}/usr/bin RUNDIR=/usr/lib/paxtest || die
}

src_install() {
	emake DESTDIR=${D} BINDIR=/usr/bin RUNDIR=/usr/lib/paxtest install
	for doc in Changelog COPYING LICENCE README ;do
		[ -f "${doc}" ] && dodoc ${doc}
	done
}
