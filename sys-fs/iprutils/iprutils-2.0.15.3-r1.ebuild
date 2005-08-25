# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/iprutils/iprutils-2.0.15.3-r1.ebuild,v 1.3 2005/08/25 18:00:38 swegener Exp $

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="IBM's tools for support of the ipr SCSI controller"
SRC_URI="mirror://sourceforge/iprdd/${P}-src.tgz"
HOMEPAGE="http://sourceforge.net/projects/iprdd/"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="~ppc64"
IUSE=""

DEPEND="virtual/libc
		>=sys-libs/ncurses-5.4-r5
		>=sys-apps/pciutils-2.1.11-r1
		>=sys-fs/sysfsutils-1.3.0
		sys-apps/hotplug"

src_install () {
	make INSTALL_MOD_PATH=${D} install || die
	dodoc ChangeLog LICENSE

	dodir /etc/init.d
	exeinto /etc/init.d
	newexe ${FILESDIR}/iprinit iprinit
	newexe ${FILESDIR}/iprupdate iprupdate
	newexe ${FILESDIR}/iprdump iprdump
}

pkg_postinst() {
	einfo "This package also contains several init.d files. "
	einfo "You should add them to your default runlevels as follows:"
	einfo "rc-update add iprinit default"
	einfo "rc-update add iprdump default"
	einfo "rc-update add iprupdate default"
	ebeep 5
}
