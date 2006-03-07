# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/t-coffee/t-coffee-3.84.ebuild,v 1.1 2006/03/07 21:41:22 spyderous Exp $

inherit toolchain-funcs

DESCRIPTION="A multiple sequence alignment package"
LICENSE="t-coffee"
HOMEPAGE="http://igs-server.cnrs-mrs.fr/~cnotred/Projects_home_page/t_coffee_home_page.html"
SRC_URI="http://igs-server.cnrs-mrs.fr/~cnotred/Packages/T-COFFEE_distribution_Version_${PV}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~ppc ~x86"

RESTRICT="nomirror"

DEPEND="sci-biology/clustalw"

TCDIR="${WORKDIR}/T-COFFEE_distribution_Version_${PV}"
S="${TCDIR}/t_coffee_source"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s/CC	= cc/CC	= $(tc-getCC) ${CFLAGS}/" -i makefile || die \
		"Failed to patch makefile."
}

die_compile() {
	echo
	eerror "If you experience an internal compiler error (consult the above"
	eerror "messages), try compiling t-coffee using very modest compiler flags."
	eerror "See bug #114745 on the Gentoo Bugzilla for more details."
	die "Compilation failed"
}

src_compile() {
	make all || die_compile
}

src_install() {
	cd "${TCDIR}"/bin
	dobin t_coffee || die "Failed to install program."
	insinto /usr/share/${PN}/lib/html
	doins ${TCDIR}/html/* || die "Failed to install HTML documentation,"

	dodoc ${TCDIR}/doc/README4T-COFFEE || die \
		"Failed to install basic documentation."
	insinto /usr/share/doc/${PF}
	doins ${TCDIR}/doc/t_coffee{_doc.{doc,pdf},.pdf} || die \
		"Failed to install manuals and articles."
	doins ${TCDIR}/doc/*.txt || die "Failed to install documentation."

	insinto /usr/share/${PN}/example
	doins ${TCDIR}/example/* || die "Failed to install example files."
}
