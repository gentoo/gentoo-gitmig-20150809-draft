# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.13.4.ebuild,v 1.1 2004/02/09 21:13:09 mholzer Exp $

inherit distutils

DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://rdiff-backup.stanford.edu/${P}.tar.gz"
HOMEPAGE="http://rdiff-backup.stanford.edu"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"

RDEPEND="${RDEPEND} >=net-libs/librsync-0.9.6"
