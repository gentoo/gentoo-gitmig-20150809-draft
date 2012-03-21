# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/theseus/theseus-1.6.2.ebuild,v 1.1 2012/03/21 13:17:03 jlec Exp $

EAPI=4

inherit multilib toolchain-funcs

DESCRIPTION="maximum likelihood superpositioning and analysis of macromolecular structures"
HOMEPAGE="http://www.theseus3d.org/"
SRC_URI="http://www.theseus3d.org/src/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

RDEPEND="
	sci-libs/gsl
	|| (
		sci-biology/clustalw
		sci-biology/muscle
		)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}"/${PN}_src/

src_prepare() {
	cat >> make.inc <<- EOF
	ARCH = $(tc-getAR)
	ARCHFLAGS = -rvs
	RANLIB = $(tc-getRANLIB)
	LOCALLIBDIR = "${EPREFIX}/usr/$(get_libdir)
	SYSLIBS = $(pkg-config --libs gsl) -lpthread
	LIBS = -ldistfit -lmsa -ldssplite -ldltmath -lDLTutils -ltheseus
	LIBDIR = -L./lib
	INSTALLDIR = "${ED}"/usr/bin
	OPT =
	WARN = -Wall -pedantic -std=c99 #-Wstrict-aliasing=2
	CFLAGS = ${CFLAGS} \$(WARN) #-force_cpusubtype_ALL -mmacosx-version-min=10.4 -arch x86_64 -arch i386 #-DNDEBUG
	CC = $(tc-getCC)
	EOF

	sed \
		-e 's|theseus:|theseus: libs|g' \
		-e '/-o theseus/s:$(CC):$(CC) ${LDFLAGS}:g' \
		-i Makefile || die
}

src_install() {
	dobin theseus theseus_align
	dodoc theseus_man.pdf README AUTHORS
	use examples && insinto /usr/share/${PN} && doins -r examples
}
