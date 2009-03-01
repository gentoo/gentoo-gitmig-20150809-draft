# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/dvhtool/dvhtool-1.0.1-r2.ebuild,v 1.3 2009/03/01 23:26:14 kumba Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Tool to copy kernel(s) into the volume header on SGI MIPS-based workstations."
HOMEPAGE="http://packages.debian.org/unstable/utils/dvhtool"
SRC_URI="mirror://debian/pool/main/d/dvhtool/dvhtool_1.0.1.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~mips ~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}.orig"

	# several applicable hunks from a debian patch
	epatch "${FILESDIR}"/${P}-debian.diff

	# Newer minor patches from Debian
	epatch "${FILESDIR}"/${P}-debian-warn_type_guess.diff
	epatch "${FILESDIR}"/${P}-debian-xopen_source.diff

	# Allow dvhtool to recognize Linux RAID and Linux LVM partitions
	epatch "${FILESDIR}"/${P}-add-raid-lvm-parttypes.patch
}

src_compile() {
	cd "${S}.orig"
	CC=$(tc-getCC) LD=$(tc-getLD) \
		econf || die "econf failed"

	CC=$(tc-getCC) LD=$(tc-getLD) \
		emake || die "Failed to compile"
}

src_install() {
	cd "${S}.orig"
	einstall
}
