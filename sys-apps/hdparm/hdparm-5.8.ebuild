# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.8.ebuild,v 1.1 2004/11/23 16:20:39 chainsaw Exp $

inherit gcc

DESCRIPTION="Utility to change hard drive performance parameters"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/hardware/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^CC/s:gcc:$(gcc-getCC):" \
		-e "/^CFLAGS/s:-O2:${CFLAGS}:" \
		Makefile || die
}

src_compile() {
	emake || die "compile error"
}

src_install() {
	into /
	dosbin hdparm contrib/idectl || die "dosbin"

	exeinto /etc/init.d
	newexe ${FILESDIR}/hdparm-init-7 hdparm || die "init.d"
	insinto /etc/conf.d
	newins ${FILESDIR}/hdparm-conf.d.3 hdparm

	doman hdparm.8
	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}

pkg_postinst() {
	einfo "The rc-script for hdparm has been updated, so make sure "
	einfo "that you etc-update.  The script is much more configurable"
	einfo "for details please see /etc/conf.d/hdparm"
}
