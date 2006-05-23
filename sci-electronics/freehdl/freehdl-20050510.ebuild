# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/freehdl/freehdl-20050510.ebuild,v 1.3 2006/05/23 09:43:55 calchan Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A free VHDL simulator."
SRC_URI="http://cran.mit.edu/~enaroska/${P}.tar.gz"
HOMEPAGE="http://freehdl.seul.org/"
LICENSE="GPL-2"
DEPEND="sys-devel/flex
	>=sys-devel/gcc-3.4.3.20050110-r2"
RDEPEND=">=dev-util/guile-1.2"
SLOT="0"
IUSE=""
KEYWORDS="~ppc"

src_unpack() {
	if [ $(gcc-major-version) -le 3 -a $(gcc-minor-version) -le 4 ] \
	&& [ $(gcc-micro-version) -lt 3 -o $(gcc-minor-version) -lt 4 ]; then
		die "You need at least gcc 3.4.3.20050110-r2 to compile freehdl." \
			"You are using $(gcc-fullversion)"
	fi
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-memory.patch
	touch vaul/lexer.ll # rebuild the lexer, see bug #103157
}

src_install () {
	emake DESTDIR=${D} install || die "installation failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
