# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.2-r2.ebuild,v 1.7 2003/02/13 15:59:38 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://metalab.unc.edu/pub/Linux/system/hardware/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

src_compile() {
	emake || die "compile error"
}

src_install() {
	into /
	dosbin hdparm contrib/idectl
	
	insinto /etc/init.d
	newins ${FILESDIR}/hdparm-init hdparm
	
	doman hdparm.8
	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}

