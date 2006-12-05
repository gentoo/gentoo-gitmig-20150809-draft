# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ecryptfs-utils/ecryptfs-utils-3.ebuild,v 1.2 2006/12/05 17:19:22 mr_bones_ Exp $

DESCRIPTION="eCryptfs userspace utilities"
HOMEPAGE="http://www.ecryptfs.org"
SRC_URI="mirror://sourceforge/ecryptfs/ecryptfs-util-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-apps/keyutils
	dev-libs/libgcrypt"

RESTRICT="confcache"

src_install(){
	emake -j1 DESTDIR=${D} install || die
}
