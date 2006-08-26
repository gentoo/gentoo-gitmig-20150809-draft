# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-jaxp/gnu-jaxp-1.3-r1.ebuild,v 1.1 2006/08/26 14:35:35 betelgeuse Exp $

inherit eutils java-pkg-2

MY_P=${PN/gnu-/}-${PV}

DESCRIPTION="GNU JAXP, a free implementation of SAX parser API, DOM Level 2, Sun JAXP 1.1."
HOMEPAGE="http://www.gnu.org/software/classpathx/jaxp/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/classpathx/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc source"

# Should work with 1.3 but did not test yet after migration to gen 2
RDEPEND="=virtual/jre-1.4*
		=dev-libs/libxml2-2*
		dev-libs/libxslt"
DEPEND="=virtual/jdk-1.4*
		${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --disable-gcj || die "configure failed!"
	emake gnujaxp.jar $(use_doc) || die "compile failed!"
}

src_install() {
	java-pkg_dojar gnujaxp.jar
	dodoc README
	use doc && java-pkg_dohtml -r apidoc/*
	use source && java-pkg_dosrc source/*
}
