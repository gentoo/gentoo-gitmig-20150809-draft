# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-logging/commons-logging-1.0.3.ebuild,v 1.1 2003/04/23 02:20:11 absinthe Exp $

inherit jakarta-commons

S="${WORKDIR}/${P}-src/"
DESCRIPTION="The Jakarta-Commons Logging package is an ultra-thin bridge between different logging libraries."
HOMEPAGE="http://jakarta.apache.org/commons/logging.html"
SRC_URI="http://apache.ttlhost.com/jakarta/commons/logging/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/log4j-1.2.5
	>=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="doc jikes junit"

src_compile() {
	[ -f LICENSE.txt ] && cp LICENSE.txt ../LICENSE
	jakarta-commons_src_compile myconf make
	jakarta-commons_src_install dojar
	use doc && jakarta-commons_src_compile makedoc
	use doc && jakarta-commons_src_install html
}
