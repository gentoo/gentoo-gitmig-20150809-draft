# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.10.1-r1.ebuild,v 1.1 2002/12/17 19:47:37 blauwers Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://www.stanford.edu/~bescoto/rdiff-backup/${P}.tar.gz"
HOMEPAGE="http://www.stanford.edu/~bescoto/rdiff-backup/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

RDEPEND=">=net-libs/librsync-0.9.5"

inherit distutils

src_compile() {
	patch -p0 < ${FILESDIR}/rpath.patch || die
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
