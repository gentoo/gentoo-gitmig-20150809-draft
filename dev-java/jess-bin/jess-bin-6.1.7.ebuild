# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jess-bin/jess-bin-6.1.7.ebuild,v 1.3 2005/07/16 10:13:12 axxo Exp $

inherit java-pkg

DESCRIPTION="Jess, the expert system shell for the Java platform"
HOMEPAGE="http://herzberg.ca.sandia.gov/jess/"
SRC_URI="Jess61p7.tgz"
MY_PN="Jess61p7"

LICENSE="jess"
SLOT="0"
KEYWORDS="~x86 ~ppc"
RESTRICT="fetch"
IUSE="doc"
DEPEND=""
RDEPEND=">=virtual/jre-1.2"

S=${WORKDIR}/${MY_PN}

pkg_nofetch() {
	einfo "Please visit http://herzberg.ca.sandia.gov/jess/download.shtml"
	einfo "and download ${SRC_URI}."
	einfo "Just save it in ${DISTDIR} !"
}

src_install() {
	java-pkg_dojar jess.jar

	dodoc README

	if use doc; then
		echo "Installing documentation..."
		java-pkg_dohtml -r docs/*
		insinto /usr/share/doc/${P/-bin}/examples/
		doins examples/*

		for i in pumps simple xfer; do
			insinto /usr/share/doc/${P/-bin}/examples/$i
			doins jess/examples/$i/*
		done
	fi
}

pkg_postinst() {
	einfo "Online Documentation: "
	einfo "     http://herzberg.ca.sandia.gov/jess/docs/index.shtml"
}
