# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/which/which-2.16.ebuild,v 1.12 2004/03/21 21:03:12 vapier Exp $

inherit eutils

DESCRIPTION="Prints out location of specified executables that are in your path"
HOMEPAGE="http://www.xs4all.nl/~carlo17/which/"
SRC_URI="http://www.xs4all.nl/~carlo17/which/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64 sparc alpha mips hppa amd64 ia64 s390"

RDEPEND="virtual/glibc
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/which-gentoo.patch
}

src_install() {
	dobin which || die
	doman which.1
	doinfo which.info
	dodoc AUTHORS EXAMPLES NEWS README*
}
