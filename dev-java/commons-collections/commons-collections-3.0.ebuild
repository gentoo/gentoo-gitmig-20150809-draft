# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-collections/commons-collections-3.0.ebuild,v 1.1 2004/02/27 03:45:00 zx Exp $

inherit jakarta-commons

DESCRIPTION="Jakarta-Commons Collections Component"
HOMEPAGE="http://jakarta.apache.org/commons/collections.html"
SRC_URI="mirror://apache/jakarta/commons/collections/source/${PN}-${PV}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="3"
KEYWORDS="~x86"
IUSE="doc jikes junit"

src_compile() {
	jakarta-commons_src_compile myconf make
	use doc && jakarta-commons_src_compile makedoc
}

src_install() {
	java-pkg_dojar build/commons-collections-3.0.jar
	dodoc LICENSE.txt README.txt
	use doc && dohtml -r build/docs/apidocs
	dohtml *.html
}

