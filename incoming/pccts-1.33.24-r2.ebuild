# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Peter Kadau <peter.kadau@web.de>
# $HEADER$

S=${WORKDIR}/pccts
DESCRIPTION="An embedded C/C++ parser generator"
SRC_URI="http://www.polhode.com/pccts133mr24.zip"
HOMEPAGE="http://www.polhode.com/"

DEPEND="app-arch/unzip"
RDEPEND=""

src_unpack() {
	unpack ${A}

	patch -p0 <${FILESDIR}/${PF}-gentoo.diff
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
	insinto /usr/include/pccts/sorcerer/include
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
