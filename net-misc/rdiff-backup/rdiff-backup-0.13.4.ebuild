# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.13.4.ebuild,v 1.10 2005/05/27 07:50:58 pylon Exp $

inherit distutils

DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
HOMEPAGE="http://www.nongnu.org/rdiff-backup/"
SRC_URI="http://www.nongnu.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc sparc x86"
IUSE=""

RDEPEND=">=net-libs/librsync-0.9.6"
