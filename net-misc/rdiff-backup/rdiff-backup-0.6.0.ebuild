# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Justin <justin@skiingyac.com>
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.6.0.ebuild,v 1.1 2002/04/29 09:00:55 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://www.stanford.edu/~bescoto/rdiff-backup/${P}.tar.gz"
HOMEPAGE="http://www.stanford.edu/~bescoto/rdiff-backup/"

DEPEND=">=net-libs/librsync-0.9.5
	>=dev-lang/python-2.2"

src_install () {
	dobin rdiff-backup
	doman rdiff-backup.1
	dodoc COPYING README CHANGELOG
	dohtml FAQ.html
}
