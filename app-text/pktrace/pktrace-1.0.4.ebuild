# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pktrace/pktrace-1.0.4.ebuild,v 1.3 2002/09/23 19:12:02 vapier Exp $

DESCRIPTION="small Python program to trace TeX fonts to PFA or PFB fonts"
HOMEPAGE="http://www.cs.uu.nl/~hanwen/pktrace/"
SRC_URI="http://www.cs.uu.nl/~hanwen/pktrace/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SLOT="1"

DEPEND=">=dev-lang/python-2.2.1
	>=media-gfx/autotrace-0.30
	>=app-text/t1utils-1.25
	>=tetex-1.0.7"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	ln -s GNUmakefile Makefile # workaround for einstall
	einstall || die "einstall failed"
}
