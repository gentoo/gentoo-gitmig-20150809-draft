# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gpart/gpart-0.1h-r1.ebuild,v 1.1 2005/02/12 01:23:51 vapier Exp $

inherit eutils

DESCRIPTION="Partition table rescue/guessing tool"
HOMEPAGE="http://www.stud.uni-hannover.de/user/76201/gpart/"
SRC_URI="http://www.stud.uni-hannover.de/user/76201/gpart/${P}.tar.gz
	ftp://ftp.namesys.com/pub/misc-patches/gpart-0.1h-reiserfs-3.6.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-errno.patch
	epatch "${FILESDIR}"/${P}-vfat.patch
	epatch "${FILESDIR}"/${P}-ntfs.patch
	epatch "${WORKDIR}"/gpart-0.1h-reiserfs-3.6.patch
}

src_install() {
	dobin src/gpart || die
	doman man/gpart.8
	dodoc README CHANGES INSTALL LSM
}
