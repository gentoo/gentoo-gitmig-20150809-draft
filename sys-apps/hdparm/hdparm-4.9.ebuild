# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-4.9.ebuild,v 1.3 2002/07/14 19:20:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://metalab.unc.edu/pub/Linux/system/hardware/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"
KEYWORDS="x86"
DEPEND="virtual/glibc"
SLOT="0"
LICENSE="BSD"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:-s::" -e "s/-O2/${CFLAGS}/" \
	Makefile.orig > Makefile
}

src_compile() {
	emake all || die
}

src_install() {
	into /
	dosbin hdparm contrib/idectl
	doman hdparm.8
	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}


