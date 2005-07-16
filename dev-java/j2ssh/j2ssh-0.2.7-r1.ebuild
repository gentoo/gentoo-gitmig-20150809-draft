# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/j2ssh/j2ssh-0.2.7-r1.ebuild,v 1.8 2005/07/16 11:56:52 axxo Exp $

inherit java-pkg

DESCRIPTION="Java SSH API"
HOMEPAGE="http://sourceforge.net/projects/sshtools/"
SRC_URI="mirror://sourceforge/sshtools/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc examples jikes source"

RDEPEND=">=virtual/jre-1.3
	dev-java/commons-logging
	=dev-java/xerces-2.6*"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f commons-logging.jar xercesImpl.jar xmlParserAPIs.jar
	#use jce-jdk13-119.jar source not available and we need use based deps
	java-pkg_jar-from commons-logging
	java-pkg_jar-from xerces-2
}

src_compile() {
	local antflags="build"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflag="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar dist/lib/*.jar
	insinto /usr/share/${PN}
	doins j2ssh.properties

	use doc && java-pkg_dohtml -r docs/
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -R ${S}/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/*
}
