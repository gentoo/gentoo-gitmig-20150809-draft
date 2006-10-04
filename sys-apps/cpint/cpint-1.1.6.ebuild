# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpint/cpint-1.1.6.ebuild,v 1.4 2006/10/04 14:16:00 vapier Exp $

inherit linux-info

MY_PV=${PV//./}

DESCRIPTION="Linux/390 Interface to z/VM's Control Program"
HOMEPAGE="http://linuxvm.org/Patches/index.html"
SRC_URI="http://linuxvm.org/Patches/s390/${PN}${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="s390"
IUSE=""

DEPEND=""

src_compile() {
	emake INCLUDEDIR=-I/usr/src/linux/include || die "emake failed"
}

src_install() {
	einstall prefix="${D}" || die
	rm -rf "${D}"/lib/modules/misc
	dodoc ChangeLog HOW-TO
}
