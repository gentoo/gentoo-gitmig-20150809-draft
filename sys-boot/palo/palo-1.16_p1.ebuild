# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/palo/palo-1.16_p1.ebuild,v 1.1 2009/05/07 05:06:48 jer Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="PALO : PArisc Linux Loader"
HOMEPAGE="http://parisc-linux.org/"
SRC_URI="mirror://debian/pool/main/p/palo/palo_1.16+nmu1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~hppa"
IUSE=""

DEPEND=""
PROVIDE="virtual/bootloader"

S="${WORKDIR}/palo-1.16+nmu1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-remove-HOME-TERM.patch
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-version.patch
}

src_compile() {
	tc-export CC
	emake -C palo || die "make palo failed"
	emake -C ipl || die "make ipl failed"
	emake MACHINE=parisc iplboot || die "make iplboot failed"
}

src_install() {
	dosbin palo/palo || die
	doman palo.8
	dohtml README.html
	dodoc README palo.conf

	insinto /etc
	doins "${FILESDIR}"/palo.conf || die

	insinto /usr/share/palo
	doins iplboot || die
}
