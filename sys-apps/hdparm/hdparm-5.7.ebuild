# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.7.ebuild,v 1.1 2004/09/04 18:30:28 chainsaw Exp $

inherit gcc eutils

DESCRIPTION="Utility to change hard drive performance parameters"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/hardware/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
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
	dosbin hdparm contrib/idectl || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/hdparm-init-6 hdparm

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
