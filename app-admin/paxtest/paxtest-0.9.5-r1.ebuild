# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/paxtest/paxtest-0.9.5-r1.ebuild,v 1.16 2010/09/18 17:33:48 blueness Exp $

inherit eutils

# pax flags are not strip safe.
RESTRICT="strip"

DESCRIPTION="PaX regression test suite"
HOMEPAGE="http://pageexec.virtualave.net/"
#SRC_URI="http://pageexec.virtualave.net/paxtest-${PV}.tar.gz"
SRC_URI="mirror://gentoo/paxtest-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=sys-apps/chpax-0.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/paxtest-0.9.5.1.diff

	# paxtest includes crt1S.S, which is great if you're on x86, but not so
	# much if you're not...
	use !x86 && epatch "${FILESDIR}"/paxtest-0.9.5-use-fPIE.patch

	cp Makefile{,.orig}
	cp Makefile{.Gentoo-hardened,}
}

src_compile() {
	emake DESTDIR="${D}" BINDIR="${D}"/usr/bin RUNDIR=/usr/lib/paxtest || die
}

src_install() {
	emake DESTDIR="${D}" BINDIR=/usr/bin RUNDIR=/usr/lib/paxtest install
	for doc in Changelog README ;do
		[ -f "${doc}" ] && dodoc ${doc}
	done
}
