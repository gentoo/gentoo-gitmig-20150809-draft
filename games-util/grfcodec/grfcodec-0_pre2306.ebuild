# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/grfcodec/grfcodec-0_pre2306.ebuild,v 1.7 2010/10/15 13:49:56 maekke Exp $

EAPI=2
inherit eutils toolchain-funcs

MY_PV=${PV/0_pre/r}
DESCRIPTION="A suite of programs to modify openttd/Transport Tycoon Deluxe's GRF files"
HOMEPAGE="http://binaries.openttd.org/extra/grfcodec/"
SRC_URI="http://binaries.openttd.org/extra/grfcodec/${MY_PV}/${PN}-${MY_PV}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE=""

S=${WORKDIR}/${PN}-${MY_PV}

DEPEND="dev-lang/perl
	dev-libs/boost"
RDEPEND=""

src_prepare() {
	cat > Makefile.local <<-__EOF__
		CC = $(tc-getCC)
		CXX = $(tc-getCXX)
		CFLAGS = ${CFLAGS}
		CXXFLAGS = ${CXXFLAGS}
		LDOPT = ${LDFLAGS}
		STRIP = :
		V = 1
	__EOF__

	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	dobin ${PN} grf{diff,merge} || die
	dodoc *.txt Changelog || die
}
