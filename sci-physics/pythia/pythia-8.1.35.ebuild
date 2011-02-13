# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/pythia/pythia-8.1.35.ebuild,v 1.8 2011/02/13 17:35:53 armin76 Exp $

EAPI=2

inherit eutils versionator

MV=$(get_major_version)
MY_P=${PN}$(replace_all_version_separators "" ${PV})

DESCRIPTION="Lund Monte Carlo high-energy physics event generator"
HOMEPAGE="http://home.thep.lu.se/~torbjorn/Pythia.html"
SRC_URI="http://home.thep.lu.se/~torbjorn/${PN}${MV}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="8"
KEYWORDS="amd64 hppa x86"
IUSE="doc examples +hepmc"

DEPEND="hepmc? ( sci-physics/hepmc )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	use hepmc && export HEPMCVERSION=2 HEPMCLOCATION=/usr
	# homemade configure script creates a useless config.mk
	rm -f config.mk
	cat > config.mk <<-EOF
		SHAREDLIBS = yes
		LDFLAGSSHARED = -shared ${LDFLAGS}
		LDFLAGLIBNAME = -Wl,-soname
		SHAREDSUFFIX = so
	EOF
}

src_test() {
	cd "${S}"/examples
	# use emake for parallel instead of long runmains
	emake \
		$(ls main0{1..9}*.cc | sed -e 's/.cc//') \
		|| die "emake tests failed"
	for i in main0{1..9}*.exe; do
		./${i} > ${i}.out || die "test ${i} failed"
	done
	if use hepmc; then
		emake main31 main32 || die "emake tests for hepmc failed"
		./main31.exe > main31.exe.out || die
		./main32.exe main32.cmnd hepmcout32.dat > main32.exe.out || die
	fi
	emake clean && rm -f main*out
}

src_install() {
	dolib.so lib/*so || die "shared lib install failed"
	dolib.a lib/archive/* || die "static lib install failed"

	insinto /usr/include/${PN}
	doins include/* || die "headers install failed"

	# xmldoc needed by root
	insinto /usr/share/${PN}
	doins -r xmldoc || die "xmldoc install failed"
	echo PYTHIA8DATA=/usr/share/${PN}/xmldoc >> 99pythia8
	doenvd 99pythia8

	insinto /usr/share/doc/${PF}
	dodoc GUIDELINES AUTHORS README
	if use doc; then
		doins worksheet.pdf || die "doc install failed"
		mv htmldoc html
		doins -r html || die "html doc install failed"
	fi
	if use examples; then
		doins -r examples || die "examples install failed"
	fi
}
