# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpint/cpint-1.1.6.ebuild,v 1.3 2004/06/30 14:43:30 agriffis Exp $

MY_PV=${PV//./}

DESCRIPTION="Linux/390 Interface to z/VM's Control Program"
SRC_URI="http://linuxvm.org/Patches/s390/${PN}${MY_PV}.tgz"
HOMEPAGE="http://linuxvm.org/Patches/index.html"
LICENSE="GPL-2"
KEYWORDS="s390"
IUSE=""
SLOT="${KV}"
DEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	check_KV || die "Cannot find kernel in /usr/src/linux"
	einfo "Using kernel in /usr/src/linux:- ${KV}"

	emake INCLUDEDIR=-I/usr/src/linux/include || die "emake failed"
}

src_install() {
	einstall prefix=${D}
	rm -rf ${D}/lib/modules/misc
	dodoc ChangeLog HOW-TO
}
