# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.12.7.ebuild,v 1.6 2004/09/18 16:23:56 weeve Exp $

inherit distutils

DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://rdiff-backup.stanford.edu/${P}.tar.gz"
HOMEPAGE="http://rdiff-backup.stanford.edu"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""
SLOT="0"

RDEPEND=">=net-libs/librsync-0.9.6"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
