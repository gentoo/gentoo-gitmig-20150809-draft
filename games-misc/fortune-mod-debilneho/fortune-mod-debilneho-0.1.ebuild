# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-debilneho/fortune-mod-debilneho-0.1.ebuild,v 1.1 2004/02/05 02:07:19 vapier Exp $

MY_PN=${PN/mod-/}
DESCRIPTION="Quotation's by several people (mostly from Slovakia)"
HOMEPAGE=""
SRC_URI="http://megac.info/fortune-debilneho.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_PN}

src_install() {
	insinto /usr/share/fortune
	doins debilneho debilneho.dat
}
