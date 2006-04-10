# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/setarch/setarch-1.8.ebuild,v 1.4 2006/04/10 23:08:16 vapier Exp $

inherit eutils

DESCRIPTION="change reported architecture in new program environment and set personality flags"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="!sys-apps/linux32
	!sys-devel/mips32
	!sys-devel/sparc32
	!sys-devel/ppc32"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${FILESDIR}"/Makefile . || die
	epatch "${FILESDIR}"/${P}-linux-headers.patch
	epatch "${FILESDIR}"/${P}-mips.patch
	epatch "${FILESDIR}"/${P}-sparc.patch
	epatch "${FILESDIR}"/${P}-better-error.patch
	epatch "${FILESDIR}"/${P}-links.patch
	epatch "${FILESDIR}"/${P}-help.patch
	epatch "${FILESDIR}"/${P}-switch-64bit-fallback.patch
}

src_install() {
	make install DESTDIR="${D}" || die
}
