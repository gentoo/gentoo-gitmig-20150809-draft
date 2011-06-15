# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpuid/cpuid-20110305.ebuild,v 1.1 2011/06/15 12:11:32 hwoarang Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Utility to get detailed information about the CPU(s) using the
CPUID instruction"
HOMEPAGE="http://www.etallen.com/cpuid.html"
SRC_URI="http://www.etallen.com/${PN}/${P}.src.tar.gz"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	emake BUILDROOT="${D}" install
}
