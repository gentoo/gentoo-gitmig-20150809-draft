# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-01.03.ebuild,v 1.2 2003/09/21 09:54:28 solar Exp $

inherit flag-o-matic

MY_P="${P/-/-A.}"
DESCRIPTION="Hardware Lister"
HOMEPAGE="http://ezix.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/${MY_P}"

src_compile() {
	# cpuid.cc uses inline asm and can not be linked when
	# position independent code is desired.
	filter-flags -fPIC
	has_version 'sys-devel/hardened-gcc' && append-flags -yet_exec
	emake CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
}
