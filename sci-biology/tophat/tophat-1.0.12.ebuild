# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/tophat/tophat-1.0.12.ebuild,v 1.1 2009/12/07 15:50:08 weaver Exp $

EAPI="2"

inherit autotools

DESCRIPTION="A fast splice junction mapper for RNA-Seq reads"
HOMEPAGE="http://tophat.cbcb.umd.edu/"
SRC_URI="http://tophat.cbcb.umd.edu/downloads/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

DEPEND="sci-biology/bowtie"
RDEPEND="${DEPEND}"

src_prepare() {
	# fix gcc-4.4 missing include
	sed -i '/#include <string>/ a #include <stdio.h>' "${S}/src/gff_juncs.cpp" || die
	# fix parallel make race
	sed -i -e 's/\$(top_builddir)\/src\///g' src/Makefile.am || die
	eautoreconf || die
}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS THANKS
}
