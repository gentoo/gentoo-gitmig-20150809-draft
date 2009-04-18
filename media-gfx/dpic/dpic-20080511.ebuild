# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/dpic/dpic-20080511.ebuild,v 1.2 2009/04/18 22:18:52 zzam Exp $

inherit toolchain-funcs

DESCRIPTION="Converts PIC plots into pstricks, PGF/TikZ, PostScript, MetaPost and TeX"
HOMEPAGE="http://ece.uwaterloo.ca/~aplevich/dpic"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""

S="${WORKDIR}/${PN}"

src_compile () {
	# Instead of patching the makefile, we just create a new one that will use
	# cflags, ldflags & friends
	echo "LDLIBS=-lm" > Makefile
	echo "dpic: dpic.o dpic2.o p2clib.o" >> Makefile
	tc-export CC
	emake || die "emake failed"
}

src_install () {
	dobin dpic || die "installing dpic failed"
	dodoc README doc/dpic_man.txt doc/gpic.ps.gz || die "installing docs failed"
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins doc/examples/README doc/examples/Examples.txt doc/examples/sources/* || die "installing examples failed"
	fi
}
