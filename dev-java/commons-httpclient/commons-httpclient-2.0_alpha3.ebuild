# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-httpclient/commons-httpclient-2.0_alpha3.ebuild,v 1.3 2003/04/26 05:36:58 strider Exp $

inherit jakarta-commons

MY_P=${P/_/-}

S="${WORKDIR}/httpclient"
DESCRIPTION="The Jakarta Commons HttpClient provides an efficient, up-to-date, and feature-rich package implementing the client side of the most recent HTTP standards and recommendations."
HOMEPAGE="http://jakarta.apache.org/commons/httpclient/index.html"
SRC_URI="mirror://apache/jakarta/commons/httpclient/${MY_P}.zip"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/log4j-1.2.5
	>=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="doc jikes junit"

src_compile() {

	jakarta-commons_src_compile myconf make
	use doc && jakarta-commons_src_compile makedoc

	# UGLY HACK
	mv ${S}/target/conf/MANIFEST.MF ${S}/target/classes/
	cd ${S}/target/classes
	zip -r ../${PN}-${PV}.jar org
}
