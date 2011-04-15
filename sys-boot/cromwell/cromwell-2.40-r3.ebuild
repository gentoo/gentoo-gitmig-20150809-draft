# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/cromwell/cromwell-2.40-r3.ebuild,v 1.6 2011/04/15 10:00:25 vapier Exp $

inherit eutils mount-boot toolchain-funcs

DESCRIPTION="Xbox boot loader"
HOMEPAGE="http://www.xbox-linux.org/wiki/Cromwell"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${PF}-cvs-fixes.patch.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="strip"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PF}-cvs-fixes.patch
	sed -i 's:-Werror::' Makefile Rules.make
	sed -i \
		-e '/^bin.imagebld:/,$s:\<gcc\>:${CC}:' \
		Makefile || die
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" LD="$(tc-getLD)" || die
}

src_install() {
	insinto /boot/${PN}
	doins image/cromwell{,_1024}.bin xbe/xromwell.xbe || die
}
