# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/wise/wise-2.1.23c.ebuild,v 1.3 2006/11/10 23:06:26 ribosome Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Intelligent algorithms for DNA searches"
LICENSE="BSD"
HOMEPAGE="http://www.ebi.ac.uk/Wise2/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/${PN}2/${PN}${PV}.tar.gz"

SLOT="0"
IUSE="threads"
KEYWORDS="~alpha ~sparc ia64 x86"

RDEPEND="=sci-biology/hmmer-2.3.2-r1"

DEPEND="${RDEPEND}
	app-shells/tcsh
	dev-lang/perl
	virtual/tetex"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use threads; then
		append-flags "-DPTHREAD"
		sed -e "s/#EXTRALIBS = -lpthread/EXTRALIBS = -lpthread/"  -i makefile || die
	fi
	sed -e "s/CC = cc/CC = $(tc-getCC)/" \
		-e "s/CFLAGS = -c -O/CFLAGS = -c ${CFLAGS}/" \
		-i makefile || die
	cd "${S}"/docs
}

src_compile() {
	cd src
	make all || die
	cd "${S}"/docs
	for i in appendix dynamite wise2 wise3arch; do
		latex ${i} || die
		latex ${i} || die
		dvips ${i}.dvi -o || die
	done
}

src_install() {
	dobin "${S}"/bin/* || die "Installing program failed"
	dolib "${S}"/base/libwisebase.a || die "Failed to install libwisebase"
	dolib "${S}"/dynlibsrc/libdyna.a || die "Failed to install libdyna"
	dobin "${S}"/dynlibsrc/testgendb || die "Failed to install testgendb"
	dolib "${S}"/models/libmodel.a || die "Failed to install libmodel"
	insinto /usr/share/${PN}
	doins -r "${S}"/wisecfg || die "Failed to install wisecfg"
	insinto /usr/share/doc/${PF}
	doins "${S}"/docs/*.ps || die "Failed to install documentation"
	newenvd "${FILESDIR}"/${PN}-env 24wise || die "Failed to install env file"
}

src_test() {
	cd "${S}"/src
	WISECONFIGDIR="${S}/wisecfg" make test || die
}
