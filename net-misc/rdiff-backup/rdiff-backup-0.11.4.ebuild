# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.11.4.ebuild,v 1.1 2003/06/29 20:39:53 mholzer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://rdiff-backup.stanford.edu/${P}.tar.gz"
HOMEPAGE="http://rdiff-backup.stanford.edu"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

RDEPEND=">=net-libs/librsync-0.9.5.1"

inherit distutils

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
