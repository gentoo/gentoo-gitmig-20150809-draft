# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-cli/commons-cli-1.0-r2.ebuild,v 1.1 2003/03/17 21:06:09 absinthe Exp $

inherit java-commons

S="${WORKDIR}/${P}"
DESCRIPTION="The CLI library provides a simple and easy to use API for working with the command line arguments and options."
HOMEPAGE="http://jakarta.apache.org/commons/logging.html"
SRC_URI="http://www.apache.org/dist/jakarta/commons/cli/source/cli-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes junit"

src_compile() {
	patch -d ${S} -p0 < ${FILESDIR}/${PN}-${PV}-gentoo.diff || die "Could not correct version in build.xml"
	java-commons_src_compile myconf make 
	use doc && java-commons_src_compile makedoc
}

