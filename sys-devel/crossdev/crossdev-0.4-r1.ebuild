# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/crossdev/crossdev-0.4-r1.ebuild,v 1.3 2004/07/15 03:12:17 agriffis Exp $

inherit eutils

DESCRIPTION="Gentoo Cross-toolchain generator"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips amd64"
IUSE=""

RDEPEND="sys-apps/portage
	app-shells/bash
	sys-apps/coreutils"


src_unpack() {
	unpack ${A}
	cd ${S}

	# Fixes some issues with portageq returning eclass names, and the cross-gcc install
	epatch ${FILESDIR}/${P}-fixes-one.patch
}

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
