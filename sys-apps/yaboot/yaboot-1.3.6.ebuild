# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Kain X <kain@kain.org>
# $Id: yaboot-1.3.6.ebuild,v 1.1 2002/04/27 10:41:11 pvdabeel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PPC Bootloader"
SRC_URI="http://penguinppc.org/projects/yaboot/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/projects/yaboot/"
DEPEND="sys-apps/powerpc-utils sys-apps/hfsutils"

MAKEOPTS='PREFIX=/usr MANDIR=/usr/share/man'

src_compile() {
	export -n CFLAGS
	export -n CXXFLAGS
	emake ${MAKEOPTS} || die
}

src_install () {
	make ROOT=${D} ${MAKEOPTS} install || die
}
