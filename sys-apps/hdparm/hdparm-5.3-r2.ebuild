# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.3-r2.ebuild,v 1.7 2003/04/16 01:10:17 gmsoft Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/hardware/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha hppa"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

src_compile() {
	einfo ""
	einfo "The rc-script for hdparm has been updated, so make sure "
	einfo "that you etc-update.  The script is much more configurable"
	einfo "for details please see /etc/conf.d/hdparm"
	einfo ""		
	emake || die "compile error"
}

src_install() {
	into /
	dosbin hdparm contrib/idectl
	
	exeinto /etc/init.d
	newexe ${FILESDIR}/hdparm-new-init hdparm
	
	insinto /etc/conf.d
	newins ${FILESDIR}/hdparm-conf.d hdparm

   	doman hdparm.8
 	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}

