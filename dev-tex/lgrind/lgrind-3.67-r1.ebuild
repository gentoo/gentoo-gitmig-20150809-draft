# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/lgrind/lgrind-3.67-r1.ebuild,v 1.2 2004/03/21 15:43:07 dholm Exp $

inherit latex-package

DESCRIPTION="A source pretty printer for LaTeX - styles to stylise your source and code examples."
SRC_URI="mirror://gentoo/${PN}.tar.gz"
LICENSE="as-is"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc"
S=${WORKDIR}/${PN}

src_compile() {

	cd ${S}/source
	emake || die "Error compiling lgrind executable"
	latex-package_src_compile

}

src_install() {

	# binary first
	dobin source/lgrind

	# then the texmf stuff
	latex-package_src_install
	insinto /usr/share/texmf/tex/latex/${PN}
	doins lgrindef

	insinto /etc/env.d
	doins ${FILESDIR}/99lgrind || die

	# and finally, the documentation
	dodoc FAQ README
	docinto examples/
	dodoc example/*
	cd ${S}/source
	doman lgrind.1 lgrindef.5

}
