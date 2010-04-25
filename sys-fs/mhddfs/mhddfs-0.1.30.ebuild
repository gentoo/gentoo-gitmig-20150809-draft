# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mhddfs/mhddfs-0.1.30.ebuild,v 1.2 2010/04/25 03:19:25 mr_bones_ Exp $

inherit eutils

MY_P="${PN}_${PV}"

DESCRIPTION="Fuse multi harddrive filesystem"
HOMEPAGE="http://mhddfs.uvw.ru/ http://svn.uvw.ru/mhddfs/trunk/README"
SRC_URI="http://mhddfs.uvw.ru/downloads/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="suid"

DEPEND=">=sys-fs/fuse-2.7.0"

src_install(){
	dobin mhddfs
	doman mhddfs.1
	dodoc ChangeLog README README.ru.UTF-8
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
