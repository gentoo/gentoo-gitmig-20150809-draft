# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/copyfs/copyfs-1.0.ebuild,v 1.3 2004/12/18 21:20:05 stuart Exp $

inherit eutils
DESCRIPTION="fuse-based filesystem for maintaining configuration files"
HOMEPAGE="http://invaders.mars-attacks.org/~boklm/copyfs/"
SRC_URI="${HOMEPAGE}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#RESTRICT="nostrip"
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
