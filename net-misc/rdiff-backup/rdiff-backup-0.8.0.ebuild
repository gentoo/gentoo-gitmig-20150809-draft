# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.8.0.ebuild,v 1.4 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://www.stanford.edu/~bescoto/rdiff-backup/${P}.tar.gz"
HOMEPAGE="http://www.stanford.edu/~bescoto/rdiff-backup/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SLOT="0"

DEPEND=">=net-libs/librsync-0.9.5
	>=dev-lang/python-2.2"

src_install () {
	dobin rdiff-backup
	doman rdiff-backup.1
	dodoc COPYING README CHANGELOG
	dohtml FAQ.html
}
