# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jess/jess-6.1.6.ebuild,v 1.2 2004/03/24 23:29:16 mholzer Exp $

inherit java-pkg

DESCRIPTION="Jess, the expert system shell for the Java platform"
HOMEPAGE="http://herzberg.ca.sandia.gov/jess/"
SRC_URI="Jess61p6.tgz"
MY_PN="Jess61p6"

LICENSE="jess"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE="doc"
DEPEND=">=virtual/jre-1.2"

S=${WORKDIR}/${MY_PN}

pkg_nofetch() {
	einfo "Please visit http://herzberg.ca.sandia.gov/jess/download.shtml"
	einfo "and download ${SRC_URI}."
	einfo "Just save it in ${DISTDIR} !"
}

src_compile() { :; }

src_install() {
	java-pkg_dojar jess.jar

	dodoc README

	if [ `use doc` ]; then
		einfo "Installing documentation..."
		dohtml -r docs/*
		insinto /usr/share/doc/${P}/examples/
		doins examples/*
		local dirs="pumps simple xfer"

		for i in $dirs; do
			insinto /usr/share/doc/${P}/examples/$i
			doins jess/examples/$i/*
		done
	fi
}

pkg_postinst() {
	einfo "Online Documentation: "
	einfo "     http://herzberg.ca.sandia.gov/jess/docs/index.shtml"
}
