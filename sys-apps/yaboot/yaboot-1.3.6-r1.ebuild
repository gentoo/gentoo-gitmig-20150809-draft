# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yaboot/yaboot-1.3.6-r1.ebuild,v 1.2 2002/06/21 20:44:48 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PPC Bootloader"
SRC_URI="http://penguinppc.org/projects/yaboot/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/projects/yaboot/"
DEPEND="sys-apps/powerpc-utils sys-apps/hfsutils"

MAKEOPTS='PREFIX=/usr MANDIR=share/man'

src_compile() {
        if [ ${ARCH} = "x86" ] ; then
                einfo "PPC Only build, sorry"
                exit 1
        fi

	export -n CFLAGS
	export -n CXXFLAGS
	emake ${MAKEOPTS} || die
}

src_install () {
	make ROOT=${D} ${MAKEOPTS} install || die
}
