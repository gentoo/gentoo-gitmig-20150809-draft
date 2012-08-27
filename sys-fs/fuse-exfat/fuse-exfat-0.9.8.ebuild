# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse-exfat/fuse-exfat-0.9.8.ebuild,v 1.1 2012/08/27 07:04:42 ssuominen Exp $

EAPI=4
inherit scons-utils toolchain-funcs

DESCRIPTION="exFAT filesystem FUSE module"
HOMEPAGE="http://code.google.com/p/exfat/"
SRC_URI="http://exfat.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-fs/fuse"
DEPEND="${RDEPEND}"

src_compile() {
	tc-export CC
	escons CCFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin fuse/mount.exfat-fuse
	dosym mount.exfat-fuse /usr/bin/mount.exfat

	doman */*.8
	dodoc ChangeLog
}
