# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/t-coffee/t-coffee-8.69.ebuild,v 1.1 2010/06/15 13:47:35 jlec Exp $

EAPI="2"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="A multiple sequence alignment package"
HOMEPAGE="http://www.tcoffee.org/Projects_home_page/t_coffee_home_page.html"
SRC_URI="http://www.tcoffee.org/Packages/T-COFFEE_distribution_Version_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

RDEPEND="sci-biology/clustalw"
DEPEND="${DEPEND}
	test? ( dev-lang/perl )"

S="${WORKDIR}/T-COFFEE_distribution_Version_${PV}"

die_compile() {
	echo
	eerror "If you experience an internal compiler error (consult the above"
	eerror "messages), try compiling t-coffee using very modest compiler flags."
	eerror "See bug #114745 on the Gentoo Bugzilla for more details."
	die "Compilation failed"
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-flags.patch
	epatch "${FILESDIR}"/${PV}-test.patch
}

src_compile() {
	[[ $(gcc-version) == "3.4" ]] && append-flags -fno-unit-at-a-time
	[[ $(gcc-version) == "4.1" ]] && append-flags -fno-unit-at-a-time
	emake \
		CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		-C t_coffee_source || die_compile
}

src_test() {
	cd "${TCDIR}"
	perl bin/test.pl || die
}

src_install() {
	dobin t_coffee || die "Failed to install program."

	insinto /usr/share/${PN}/lib/html
	doins "${TCDIR}"/html/* \
		|| die "Failed to install Web interface files."

	cd "${TCDIR}"/doc
	dodoc aln_compare.doc.txt seq_reformat.doc.txt \
			t_coffee_technical.txt t_coffee_tutorial.txt \
			|| die "Failed to install text documentation."

	dohtml t_coffee_technical.htm t_coffee_tutorial.htm \
		|| die "Failed to install HTML documentation."

	insinto /usr/share/doc/${PF}
	doins t_coffee_technical.doc t_coffee_tutorial.doc \
		|| die "Failed to install DOC documentation."

	insinto /usr/share/${PN}
	doins -r "${TCDIR}"/example \
		|| die "Failed to install example files."
}
