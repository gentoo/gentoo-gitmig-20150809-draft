# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ext2resize/ext2resize-1.1.19.ebuild,v 1.10 2006/02/15 00:18:56 vapier Exp $

inherit flag-o-matic eutils autotools

DESCRIPTION="EXT2 and EXT3 filesystem resizing utilities"
HOMEPAGE="http://ext2resize.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ppc -sparc x86"
IUSE="static"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# stupid packaged source isn't clean
	make -k distclean >& /dev/null
	sed -i '/^CFLAGS/d' src/Makefile.in

	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-blkgetsize64.patch #122787
	eautoreconf || die
}

src_compile() {
	use static && append-ldflags -static
	econf --exec-prefix=/ || die "Configure failed"
	emake LDFLAGS="${LDFLAGS}" || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	dodir /usr/sbin
	dosym /sbin/ext2online /usr/sbin/ext2online
	dosym /sbin/ext2prepare /usr/sbin/ext2prepare
	dosym /sbin/ext2resize /usr/sbin/ext2resize
}
