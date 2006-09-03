# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lha/lha-114i-r5.ebuild,v 1.2 2006/09/03 06:09:05 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Utility for creating and opening lzh archives"
HOMEPAGE="http://www2m.biglobe.ne.jp/~dolphin/lha/lha-unix.htm"
SRC_URI="http://www2m.biglobe.ne.jp/~dolphin/lha/prog/${P}.tar.gz"

LICENSE="lha"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-malloc.patch
	epatch "${FILESDIR}"/${P}-sec.patch
	epatch "${FILESDIR}"/${P}-sec2.patch
	epatch "${FILESDIR}"/${P}-symlink.patch
	epatch "${FILESDIR}"/${P}-dir_length_bounds_check.patch
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-detect-cmd-extract-fail.patch
}

src_compile() {
	use ppc-macos && append-flags -DHAVE_NO_LCHOWN
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	use linguas_jp || rm -r "${D}"/usr/share/man
	dodoc *.txt *.euc *.eng
}
