# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/crossdev/crossdev-0.4.ebuild,v 1.2 2004/02/12 16:05:26 vapier Exp $

DESCRIPTION="Gentoo Cross-toolchain generator"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips"

DEPEND="sys-apps/portage
	app-shells/bash
	sys-apps/coreutils"


src_install() {
	cd ${S}
	dobin crossdev.sh crossdev-status.sh
	dodoc BUGS README CHANGELOG TODO

	dodir /etc/crossdev
	cp crossdev.conf.example ${D}/etc/crossdev

	dosym ${D}/usr/bin/crossdev.sh /usr/bin/crossdev
	dosym ${D}/usr/bin/crossdev-status.sh /usr/bin/crossdev-status

}

pkg_postinst() {
	einfo ""
	einfo "To make use of the cross-compilers installed by this script, you need to add the"
	einfo "bin directory to your \$PATH.  Upon sucessful creation of a toolchain, the full"
	einfo "path to add to \$PATH will be displayed."
	einfo ""
}
