# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/copyfs/copyfs-1.0.ebuild,v 1.5 2007/07/02 15:32:49 peper Exp $

inherit eutils
DESCRIPTION="fuse-based filesystem for maintaining configuration files"
HOMEPAGE="http://invaders.mars-attacks.org/~boklm/copyfs/"
SRC_URI="${HOMEPAGE}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
#RESTRICT="strip"
DEPEND=">=sys-fs/fuse-2.0
	sys-apps/attr"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S} || die

	# this patch fixes sandbox violations
	epatch ${FILESDIR}/${P}-gentoo.patch

	# this patch adds support for cleaning up the versions directory
	# the patch is experimental at best, but it's better than your
	# versions directory filling up with unused files
	#
	# patch by stuart@gentoo.org
	epatch ${FILESDIR}/${P}-unlink.patch
}

src_install() {
	make DESTDIR=${D} install || die
}
