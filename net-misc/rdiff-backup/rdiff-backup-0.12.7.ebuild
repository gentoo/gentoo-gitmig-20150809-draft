# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.12.7.ebuild,v 1.8 2005/02/21 21:54:04 blubb Exp $

inherit distutils

DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://rdiff-backup.stanford.edu/${P}.tar.gz"
HOMEPAGE="http://rdiff-backup.stanford.edu"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64"
IUSE=""
SLOT="0"

RDEPEND=">=net-libs/librsync-0.9.6"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
