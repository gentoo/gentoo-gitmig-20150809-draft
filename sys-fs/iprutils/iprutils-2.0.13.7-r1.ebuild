# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/iprutils/iprutils-2.0.13.7-r1.ebuild,v 1.1 2005/03/09 05:38:17 tgall Exp $

inherit eutils

S=${WORKDIR}/iprutils
DESCRIPTION="IBM's tools for support of the ipr SCSI controller"
SRC_URI="mirror://sourceforge/iprdd/${P}-src.tgz"
HOMEPAGE="http://sourceforge.net/projects/iprdd/"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="ppc64"
IUSE=""

DEPEND="virtual/libc
		>=ncurses-5.4-r5
		>=sys-apps/pciutils-2.1.11-r1
		>=sys-fs/sysfsutils-1.2.0"

src_unpack() {
	unpack ${A}
	cd ${S}
}


src_install () {
	make INSTALL_MOD_PATH=${D} install || die
	dodoc ChangeLog LICENSE
}
