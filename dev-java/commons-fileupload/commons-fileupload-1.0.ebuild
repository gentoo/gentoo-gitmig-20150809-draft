# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-fileupload/commons-fileupload-1.0.ebuild,v 1.12 2004/10/20 05:27:00 absinthe Exp $

inherit eutils java-pkg

DESCRIPTION="The Commons FileUpload package makes it easy to add robust, high-performance, file upload capability to your servlets and web applications."
HOMEPAGE="http://jakarta.apache.org/commons/fileupload/index.html"
SRC_URI="mirror://apache/jakarta/commons/fileupload/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.5
		>=dev-java/servletapi-2.4
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~sparc ppc ~amd64"
IUSE="jikes doc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/build.xml.patch
	echo "servlet-api.jar = $(java-pkg_getjar servletapi-2.4 servlet-api.jar)" >> build.properties
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation error"
}

src_install() {
	mv ${S}/target/${P}.jar ${S}/target/${PN}.jar
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/
}
