# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yaboot/yaboot-1.3.8.ebuild,v 1.1 2002/12/11 09:47:19 cselkirk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PPC Bootloader"
SRC_URI="http://penguinppc.org/projects/yaboot/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/projects/yaboot/"
DEPEND="sys-apps/powerpc-utils sys-apps/hfsutils"
RDEPEND=""
KEYWORDS="~ppc -x86 -sparc "
MAKEOPTS='PREFIX=/usr MANDIR=share/man'
SLOT="0"
LICENSE="GPL-2"

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
