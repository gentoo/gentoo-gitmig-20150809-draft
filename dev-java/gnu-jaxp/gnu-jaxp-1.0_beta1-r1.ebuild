# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-jaxp/gnu-jaxp-1.0_beta1-r1.ebuild,v 1.7 2005/03/23 14:34:24 gustavoz Exp $

inherit java-pkg eutils

DESCRIPTION="GNU JAXP, a free implementation of SAX parser API, DOM Level 2, Sun JAXP 1.1."
HOMEPAGE="http://www.gnu.org/software/classpathx/jaxp/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/classpathx/${PN/-/}-${PV/_beta1/beta1}.zip"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 ~ppc64 ~sparc"
IUSE="doc"

S=${WORKDIR}/${PN/-/}-${PV/_beta1/beta1}

src_compile() {
	econf --disable-gcj || die "configure failed!"
	local makeflags="gnujaxp.jar"
	use doc && makeflags="${makeflags} javadoc"
	make ${makeflags} || die "compile failed!"
}

src_install () {
	java-pkg_dojar gnujaxp.jar || die "Unable to Install"
	dodoc README
	use doc && java-pkg_dohtml -r apidoc/*
}
