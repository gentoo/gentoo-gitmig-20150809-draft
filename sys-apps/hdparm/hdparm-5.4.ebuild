# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.4.ebuild,v 1.1 2003/06/27 19:16:56 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/hardware/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa"

DEPEND="virtual/glibc"

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

