# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/par/par-1.1.ebuild,v 1.16 2004/03/12 11:11:07 mr_bones_ Exp $

S=${WORKDIR}/par-cmdline
DESCRIPTION="Parchive archive fixing tool"
SRC_URI="mirror://sourceforge/parchive/par-v${PV}.tar.gz"
HOMEPAGE="http://parchive.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64"

DEPEND="virtual/glibc
		>=sys-apps/sed-4"

src_unpack() {
	unpack par-v${PV}.tar.gz
	cd ${S}
	source /etc/make.conf
	sed -i "s/CFLAGS.*/CFLAGS = -Wall $CFLAGS/" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin par
	dodoc COPYING AUTHORS NEWS README rs.doc
}
