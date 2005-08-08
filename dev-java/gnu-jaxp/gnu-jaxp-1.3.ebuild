# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-jaxp/gnu-jaxp-1.3.ebuild,v 1.6 2005/08/08 08:49:49 corsair Exp $

inherit java-pkg eutils

MY_P=${PN/gnu-/}-${PV}

DESCRIPTION="GNU JAXP, a free implementation of SAX parser API, DOM Level 2, Sun JAXP 1.1."
HOMEPAGE="http://www.gnu.org/software/classpathx/jaxp/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/classpathx/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.3
		=dev-libs/libxml2-2*
		dev-libs/libxslt"
DEPEND=">=virtual/jdk-1.3
		app-arch/unzip
		${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --disable-gcj || die "configure failed!"
	local makeflags="gnujaxp.jar"
	use doc && makeflags="${makeflags} javadoc"
	make ${makeflags} || die "compile failed!"
}

src_install() {
	java-pkg_dojar gnujaxp.jar
	dodoc README
	use doc && java-pkg_dohtml -r apidoc/*
}
