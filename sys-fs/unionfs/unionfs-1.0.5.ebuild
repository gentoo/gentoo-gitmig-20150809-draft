# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/unionfs/unionfs-1.0.5.ebuild,v 1.1 2005/01/10 19:17:34 genstef Exp $

inherit eutils linux-mod

DESCRIPTION="Stackable unification file system, which can appear to merge the
contents of several directories"
HOMEPAGE="http://www.fsl.cs.sunysb.edu/project-unionfs.html"
SRC_URI="ftp://ftp.fsl.cs.sunysb.edu/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

MODULE_NAMES="unionfs(fs:)"
BUILD_TARGETS="all"
BUILD_PARAMS="LINUXSRC=${KV_DIR} KERNELVERSION=${KV_MAJOR}.${KV_MINOR}"

src_install() {
	dosbin unionctl uniondbg
	doman man/unionfs.4 man/unionctl.8 man/uniondbg.8

	linux-mod_src_install

	dodoc README NEWS
}
