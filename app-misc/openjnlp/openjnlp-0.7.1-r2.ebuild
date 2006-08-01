# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/openjnlp/openjnlp-0.7.1-r2.ebuild,v 1.1 2006/08/01 01:51:56 nichoj Exp $

inherit java-pkg-2

DESCRIPTION="An open-source implementation of the JNLP"
HOMEPAGE="http://openjnlp.nanode.org/"
SRC_URI="mirror://sourceforge/openjnlp/OpenJNLP-src-rel_ver-${PV//./-}.zip"
LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=">=virtual/jre-1.3
		dev-java/sax
		dev-java/jnlp-bin
		dev-java/nanoxml"
DEPEND=">=virtual/jdk-1.3
		${RDEPEND}
		app-arch/unzip
		>=dev-java/ant-1.6"

S="${WORKDIR}/OpenJNLP-src-rel_ver-${PV//./-}"

src_unpack() {
	unpack ${A}
	cd ${S}/jars
	rm *.jar
	java-pkg_jar-from jnlp-bin
	java-pkg_jar-from sax
	java-pkg_jar-from nanoxml nanoxml.jar nanoxml-2.2.jar
	java-pkg_jar-from nanoxml nanoxml-sax.jar nanoxml-sax-2.2.jar

	cd ${S}
	# Fix javac stuff that can't be handled by java-ant-2
	sed -e 's/<javac/<javac target="1.3" source="1.3"/' -i targets/common.xml || die "sed failed"
}

src_compile() {
	cd ${S}/targets
	# FIXME patch targets/OpenJNLP/build.xml to do classpath correctly
	# so we don't have to pass -lib to ant
	eant -lib ../jars/MRJToolkitStubs.zip build
}

src_install() {
	cd ${S}/build/apps/unix/OpenJNLP-${PV}/

	java-pkg_dojar lib/*.jar
	java-pkg_dolauncher ${PN} --main org.nanode.app.OpenJNLP

	dodoc {History,ReadMe}.txt
}

