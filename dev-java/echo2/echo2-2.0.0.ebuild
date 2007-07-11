# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/echo2/echo2-2.0.0.ebuild,v 1.5 2007/07/11 19:58:37 mr_bones_ Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Echo2 is the next-generation of the Echo Web Framework"
HOMEPAGE="http://www.nextapp.com/platform/echo2/echo/"

# NextApp uses broken file naming, all versions of Echo2
# are named NextApp_Echo2.tgz. So you have manually put this to the mirrors
# DOWNLOAD_URI="http://www.nextapp.com/downloads/echo2/${PV}/NextApp_Echo2.tgz"

SRC_URI="mirror://gentoo/NextApp_Echo2-${PV}.tgz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/servletapi-2.4"

S="${WORKDIR}/NextApp_Echo2/"

src_compile() {

	export SERVLET_LIB_JAR=$(java-config -p servletapi-2.4)
	cd "${S}/SourceCode"
	eant dist || die "ant failed"

}

src_install() {

	java-pkg_dojar ${S}/SourceCode/dist/lib/*.jar

	use doc && {

		cd "${S}/Documentation"
		java-pkg_dohtml -r api

	}

	java-pkg_dohtml "${S}/Documentation/index.html"
	java-pkg_dohtml -r "${S}/Documentation/images"

	use source && java-pkg_dosrc "${S}/SourceCode/src"

	dodoc "${S}/readme.txt"

}
