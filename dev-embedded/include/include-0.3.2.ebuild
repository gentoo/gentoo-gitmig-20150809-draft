# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/include/include-0.3.2.ebuild,v 1.4 2004/03/27 05:08:33 dragonheart Exp $

DESCRIPTION="This is a collection of the useful independent include files for C/Assembler developers."
SRC_URI="mirror://sourceforge/openwince/${P}.tar.bz2"
HOMEPAGE="http://openwince.sourceforge.net/include/"
KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="BSD"
ISUE=""
RESTRICT="nomirror"
DEPEND="sys-apps/grep
	sys-apps/gawk"

RDEPEND=""

src_compile(){
	econf || dir "Failed to configure"
	emake || die "Failed to compile"
}

src_install(){
	emake DESTDIR=${D} install
}




