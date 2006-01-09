# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/biounzip/biounzip-1.1a.ebuild,v 1.1 2006/01/09 23:29:05 wolf31o2 Exp $

inherit eutils

S="${WORKDIR}/${P/a/}"

DESCRIPTION="Unpacks BioZip archives"
HOMEPAGE="http://biounzip.sourceforge.net/"
SRC_URI="mirror://sourceforge/biounzip/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="virtual/libc sys-libs/zlib"

src_compile() {
	sed -i -e "s#-march=athlon-xp#${CFLAGS}#" Makefile
	emake
}

src_install() {
	exeinto /usr/bin
	doexe biounzip
	dodoc biozip.txt
}

