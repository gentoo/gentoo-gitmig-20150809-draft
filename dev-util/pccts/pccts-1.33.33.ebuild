# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pccts/pccts-1.33.33.ebuild,v 1.6 2004/01/29 13:34:42 agriffis Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Purdue Compiler Construction Tool Set is an embedded C/C++ parser generator"
SRC_URI="http://www.polhode.com/pccts133mr33.zip"
HOMEPAGE="http://www.polhode.com/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc ~sparc alpha hppa amd64 ia64"

DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}

	patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	emake COPT="${CFLAGS}" || die "compilation failed"
}

src_install() {

	# main binaries
	dobin bin/{antlr,dlg,genmk,sor}

	# .c and .cpp files go into /usr/include/pccts also,
	# because genmk looks for them for being included in output-files
	# (which are c/c++) generated from grammar-files
	# right now i include _everything_ just to make sure
	# it doesn't break pccts-based projects
	#
	# if i dive further into the details of genmk.c
	# it should be possible to put that stuff into /usr/share/pccts
	#
	# the M$ and MAC specific stuff gets _not_ included
	#
	# main includes
	insinto /usr/include/pccts
	doins h/*.{h,c,cpp}

	# sorcerer includes
	insinto /usr/include/pccts/sorcerer
	doins sorcerer/h/*.{h,c,cpp}

	# sorcerer libraries
	insinto /usr/include/pccts/sorcerer/lib
	doins sorcerer/lib/*.{h,c,cpp}

	# documentation
	# leaving out the M$ and MAC stuff
	dodoc CHANGES* KNOWN_PROBLEMS* README RIGHTS history.txt history.ps
	dodoc sorcerer/README sorcerer/UPDATES

	# manual pages
	doman dlg/dlg.1 antlr/antlr.1
}
