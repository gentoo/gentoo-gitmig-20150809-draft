# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/paxtest/paxtest-0.9.1.ebuild,v 1.1 2003/08/04 17:32:53 solar Exp $

S=${WORKDIR}/${P}

DESCRIPTION="PaX regression test suite"
SRC_URI="http://pageexec.virtualave.net/paxtest-${PV}.tar.gz"
HOMEPAGE="http://pageexec.virtualave.net"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc"

src_compile() {
	# If you really paranoid you can uncomment this umask stuff.
	# local mask=$(umask)
	# umask 0077
	emake DESTDIR=${D} BINDIR=${D}/usr/bin RUNDIR=/usr/lib/paxtest || die "Parallel Make Failed"
	# umask $mask
}

src_install() {
	emake DESTDIR=${D} BINDIR=/usr/bin RUNDIR=/usr/lib/paxtest install
	for doc in Changelog COPYING LICENCE README ;do
		[ -f "${doc}" ] && dodoc ${doc}
	done
}
