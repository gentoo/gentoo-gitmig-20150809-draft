# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/sex/sex-1.0.ebuild,v 1.2 2003/11/09 03:25:35 mr_bones_ Exp $

inherit games

DESCRIPTION="Spouts silly mad-lib-style porn-like text"
HOMEPAGE="http://spatula.net/software/sex/"
SRC_URI="http://spatula.net/software/sex/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	rm -f ${S}/Makefile
}

src_compile() {
	emake sex || die "emake failed"
}

src_install() {
	dogamesbin sex || die "dogamesbin failed"
	doman sex.6    || die "doman failed"
	dodoc README   || die "dodoc failed"
	prepgamesdirs
}
