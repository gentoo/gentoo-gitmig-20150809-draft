# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/sex/sex-1.0.ebuild,v 1.1 2003/09/10 18:14:05 vapier Exp $

DESCRIPTION="Spouts silly mad-lib-style porn-like text"
HOMEPAGE="http://spatula.net/software/sex/"
SRC_URI="http://spatula.net/software/sex/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc
	sys-devel/pmake"
#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	/usr/bin/pmake || die
}

src_install() {
	dobin sex
	doman sex.6
	dodoc README
}
