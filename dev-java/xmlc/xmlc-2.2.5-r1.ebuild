# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlc/xmlc-2.2.5-r1.ebuild,v 1.2 2007/01/05 23:43:41 caster Exp $

inherit java-pkg

DESCRIPTION="Open Source Java/XML Presentation Compiler"
HOMEPAGE="http://xmlc.objectweb.org/"
SRC_URI="http://download.forge.objectweb.org/${PN}/${PN}-src-${PV}.zip
	http://download.us.forge.objectweb.org/${PN}/${PN}-src-${PV}.zip"

RDEPEND=">=virtual/jre-1.3
	dev-java/xml-commons
	dev-java/bcel
	=dev-java/gnu-regexp-1*
	=dev-java/servletapi-2.4*
	dev-java/log4j"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	app-arch/unzip
	>=dev-java/ant-core-1.4
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc jikes"

S="${WORKDIR}/${PN}-src-${PV}/"

src_unpack() {
	unpack "${A}"

	cd "${S}"/release/build-lib/ || die
	rm *.jar || die

	java-pkg_jar-from xml-commons xml-apis.jar
	java-pkg_jar-from servletapi-2.4 servlet-api.jar servlet.jar
	java-pkg_jar-from log4j

	cd "${S}"/release/lib/ || die
	rm *.jar || die
}

src_compile() {
	# doing this in src_compile so that src_compile can be manually
	# run many times
	cd "${S}"/release/lib/ || die
	java-pkg_jar-from bcel
	java-pkg_jar-from gnu-regexp-1

	cd "${S}"

	# all-libs builds xmlc-all-runtime.jar which includes for
	# example bcel in it
	local antflags="lib xmlc.jar split-wireless-jar"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compile problem"

	rm "${S}"/release/lib/{bcel,gnu-regexp}.jar || die
}

src_install() {
	java-pkg_dojar release/lib/*.jar
	dodoc release/lib/README

	# Move the generated documentation around
	if use doc; then
		mv ${PN}/modules/taskdef/doc ${PN}/modules/${PN}/doc/taskdef || die
		mv ${PN}/modules/wireless/doc ${PN}/modules/${PN}/doc/wireless || die
		mv ${PN}/modules/xhtml/doc ${PN}/modules/${PN}/doc/xhtml || die
		dohtml -r ${PN}/modules/xmlc/doc/* || die "Failed to install documentation"
	fi
}

pkg_postinst() {
	elog "This release does not install dependencies of xmlc as separate jars or"
	elog "inside the xmlc-all-runtime.jar. You should make sure to include the"
	elog "dependencies by yourself when trying to run something using xmlc."
	elog "jtidy.jar is still installed because xmlc needs a modified version of"
	elog "it."
}
