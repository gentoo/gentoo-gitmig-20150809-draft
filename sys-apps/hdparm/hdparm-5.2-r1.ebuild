# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.2-r1.ebuild,v 1.6 2002/10/19 01:52:44 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://metalab.unc.edu/pub/Linux/system/hardware/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

src_compile() {
	emake || die "compile error"
}

src_install() {
	into /
	dosbin hdparm contrib/idectl
	doman hdparm.8
	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}
