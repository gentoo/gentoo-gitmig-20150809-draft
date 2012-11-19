# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mhddfs/mhddfs-0.1.30-r1.ebuild,v 1.2 2012/11/19 11:37:46 pinkbyte Exp $

EAPI=4

inherit base eutils toolchain-funcs

MY_P="${PN}_${PV}"

DESCRIPTION="Fuse multi harddrive filesystem"
HOMEPAGE="http://mhddfs.uvw.ru/ http://svn.uvw.ru/mhddfs/trunk/README"
SRC_URI="http://mhddfs.uvw.ru/downloads/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="suid"

DEPEND=">=sys-fs/fuse-2.7.0"

DOCS="ChangeLog README README.ru.UTF-8"
PATCHES=( "${FILESDIR}/${PN}-respect-compiler-vars.patch" )

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin mhddfs
	doman mhddfs.1
	dodoc ${DOCS}
	use suid && fperms u+s /usr/bin/${PN}
}

pkg_postinst() {
	if use suid; then
		ewarn
		ewarn "You have chosen to install ${PN} with the binary setuid root. This"
		ewarn "means that if there any undetected vulnerabilities in the binary,"
		ewarn "then local users may be able to gain root access on your machine."
		ewarn
	fi
}
