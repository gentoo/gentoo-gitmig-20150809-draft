# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/cpuburn/cpuburn-1.4a.ebuild,v 1.1 2010/10/12 18:54:05 jer Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

MY_P="${PV/./_}"
DESCRIPTION="designed to heavily load CPU chips [testing purposes]"
HOMEPAGE="http://pages.sbcglobal.net/redelm/"
SRC_URI="http://pages.sbcglobal.net/redelm/cpuburn_${MY_P}_tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-baselibs-1.0 )"

src_unpack() {
	# for some reason he has it _tar instead of .tar ...
	unpack ${A}
	tar -xf cpuburn_${MY_P}_tar || die
}

src_prepare() {
cp -av Makefile{,.orig}
	epatch "${FILESDIR}"/${P}-flags.patch
	use amd64 && append-flags -m32 #65719
	tc-export CC
}

src_install() {
	dodoc Design README
	dobin burn{BX,K6,K7,MMX,P5,P6} || die
}
