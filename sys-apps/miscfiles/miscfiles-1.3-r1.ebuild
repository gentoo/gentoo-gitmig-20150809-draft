# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.3-r1.ebuild,v 1.6 2003/12/17 04:59:01 brad_mssw Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Miscellaneous files"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/miscfiles.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc sparc alpha mips hppa ~arm ia64 ppc64"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/tasks.info.diff
	epatch ${FILESDIR}/${P}-Makefile.diff
}

src_install() {
	einstall || die
	dodoc GNU* NEWS ORIGIN README dict-README
}
