# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-jaxp/gnu-jaxp-1.0_beta1.ebuild,v 1.3 2004/03/17 05:24:58 zx Exp $

inherit java-pkg

DESCRIPTION="GNU JAXP, a free implementation of SAX parser API, DOM Level 2, Sun JAXP 1.1."
HOMEPAGE="http://www.gnu.org/software/classpathx/jaxp/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/classpathx/${PN/-/}-${PV/_beta1/beta1}.zip"
DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jre-1.3"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"

S=${WORKDIR}/${PN}-${PV}

src_unpack() {
	unpack ${A}
}

src_install () {
	cd ${WORKDIR}/${P}
	java-pkg_dojar gnujaxp.jar || die "Unable to Install"
	use doc && dohtml -r apidoc/*
}
