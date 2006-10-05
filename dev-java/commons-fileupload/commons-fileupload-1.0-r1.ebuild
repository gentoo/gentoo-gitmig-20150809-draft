# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-fileupload/commons-fileupload-1.0-r1.ebuild,v 1.2 2006/10/05 15:25:36 gustavoz Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="The Commons FileUpload package makes it easy to add robust, high-performance, file upload capability to your servlets and web applications."
HOMEPAGE="http://jakarta.apache.org/commons/fileupload/"
SRC_URI="mirror://apache/jakarta/commons/fileupload/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-core-1.5
		=dev-java/servletapi-2.4*
		source? ( app-arch/unzip )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc source"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/build.xml.patch
	echo "servlet-api.jar = $(java-pkg_getjar servletapi-2.4 servlet-api.jar)" >> build.properties
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	eant ${antflags} || die "compilation error"
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/
	use source && java-pkg_dosrc src/java/*
}
