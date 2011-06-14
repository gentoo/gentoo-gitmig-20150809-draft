# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse-exfat/fuse-exfat-0.9.5.ebuild,v 1.1 2011/06/14 14:03:57 ssuominen Exp $

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
	escons CC="$(tc-getCC)" CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" || die
}

src_install() {
	# scons install is retarded and is recompiling everything, and to wrong location(s)
	into /
	dosbin fuse/mount.exfat-fuse
	dosym mount.exfat-fuse /sbin/mount.exfat

	doman */*.8
	dodoc ChangeLog
}
