# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yaboot/yaboot-1.3.7.ebuild,v 1.4 2003/01/06 09:16:33 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PPC Bootloader"
SRC_URI="http://penguinppc.org/projects/yaboot/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/projects/yaboot/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc -x86 -sparc -alpha"

DEPEND="sys-apps/powerpc-utils sys-apps/hfsutils"

PROVIDE="virtual/bootloader"

MAKEOPTS='PREFIX=/usr MANDIR=share/man'

src_compile() {
	export -n CFLAGS
	export -n CXXFLAGS
	emake ${MAKEOPTS} || die
}

src_install() {
	cp etc/yaboot.conf etc/yaboot.conf.bak
	sed -e 's/\/local//' etc/yaboot.conf >| etc/yaboot.conf.edit
	mv -f etc/yaboot.conf.edit etc/yaboot.conf
	make ROOT=${D} ${MAKEOPTS} install || die
}
