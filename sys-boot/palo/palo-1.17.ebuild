# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/palo/palo-1.17.ebuild,v 1.3 2010/07/13 01:56:26 jer Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="PALO : PArisc Linux Loader"
HOMEPAGE="http://parisc-linux.org/ http://packages.qa.debian.org/p/palo.html"
SRC_URI="mirror://debian/pool/main/p/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* hppa"
IUSE=""

DEPEND=""
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${PN}-remove-HOME-TERM.patch \
		"${FILESDIR}"/${PN}-1.16_p1-build.patch \
		"${FILESDIR}"/${PN}-1.17-fortify-source.patch
}

src_compile() {
	tc-export CC
	emake -C palo || die "make palo failed"
	emake -C ipl || die "make ipl failed"
	emake MACHINE=parisc iplboot || die "make iplboot failed"
}

src_install() {
	into /
	dosbin palo/palo || die

	doman palo.8
	dohtml README.html
	dodoc README palo.conf

	insinto /etc
	doins "${FILESDIR}"/palo.conf || die

	insinto /usr/share/palo
	doins iplboot || die
}
