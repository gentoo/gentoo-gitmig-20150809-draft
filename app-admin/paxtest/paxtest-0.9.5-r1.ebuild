# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/paxtest/paxtest-0.9.5-r1.ebuild,v 1.8 2004/07/29 09:47:21 lv Exp $

inherit eutils

# pax flags are not strip safe.
RESTRICT="nostrip"
FEATURES="-distcc"

DESCRIPTION="PaX regression test suite"
HOMEPAGE="http://pageexec.virtualave.net/"
SRC_URI="http://pageexec.virtualave.net/paxtest-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/chpax-0.5"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/paxtest-0.9.5.1.diff
	cp Makefile{,.orig}
	cp Makefile{.Gentoo-hardened,}

	# paxtest includes crt1S.S, which is great if you're on x86, but not so
	# much if you're not... lets use the system Scrt1.o
	use !x86 && cp ${ROOT}/usr/lib/Scrt1.o ${S}/crt1S.o
}

src_compile() {
	emake DESTDIR=${D} BINDIR=${D}/usr/bin RUNDIR=/usr/lib/paxtest || die
}

src_install() {
	emake DESTDIR=${D} BINDIR=/usr/bin RUNDIR=/usr/lib/paxtest install
	for doc in Changelog README ;do
		[ -f "${doc}" ] && dodoc ${doc}
	done
}

pkg_postinst() {
	use !x86 && (
	ewarn "WARNING: support for non-x86 archs is currently a hack."
	ewarn "since you're not on x86, you may get \"Accessing a corrupted shared library\""
	ewarn "during the getmain2 and getheap2 tests." )
}
