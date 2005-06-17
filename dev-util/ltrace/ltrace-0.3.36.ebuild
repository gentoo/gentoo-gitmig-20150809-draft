# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ltrace/ltrace-0.3.36.ebuild,v 1.4 2005/06/17 21:20:01 hansmi Exp $

inherit eutils

MY_P="${P/-/_}"
DEB_P="${MY_P}-2"

DESCRIPTION="ltrace shows runtime library call information for dynamically linked executables"
HOMEPAGE="http://packages.debian.org/unstable/utils/ltrace.html"
SRC_URI="mirror://debian/pool/main/l/ltrace/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/l/ltrace/${DEB_P}.diff.gz"

RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ppc -sparc x86"
IUSE=""

DEPEND="virtual/libc
	dev-libs/elfutils"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${DEB_P}.diff
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# documentation
	rm -rvf ${D}usr/doc/
	dodoc BUGS COPYING debian/changelog README TODO
}
