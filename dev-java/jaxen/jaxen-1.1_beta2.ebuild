# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxen/jaxen-1.1_beta2.ebuild,v 1.5 2005/02/03 17:16:14 luckyduck Exp $

inherit java-pkg eutils

DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="http://www.ibiblio.org/maven/jaxen/distributions/${PN}-1.1-beta-2-src.tar.gz"
LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.3
	jikes? ( dev-java/jikes )
	dev-java/ant
	>=sys-apps/sed-4
	${RDEPEND}"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/xerces-2.6.2-r1
	=dev-java/dom4j-1*"

S=${WORKDIR}/${PN}-1.1-beta-2

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	mkdir -p target/lib
	cd target/lib
	rm -f *.jar
	java-pkg_jar-from xerces-2
	java-pkg_jar-from dom4j-1

	if has_version jdom; then
		java-pkg_jar-from `best_version dev-java/jdom | sed -e s/"dev-java\/"// | sed -e s/-r.//`
	fi

	cd ${S}
	sed -i 's/depends="compile,test"/depends="compile"/' build.xml
}

src_compile() {
	local antops="jar"
	use jikes && antops="${antops} -Dbuild.compiler=jikes"
	use doc && antops="${antops} javadoc"
	ant ${antops} || die "compile failed"
}

src_install() {
	java-pkg_dojar target/jaxen*.jar

	use doc && java-pkg_dohtml -r dist/docs/*
}

pkg_postinst() {
	einfo ""
	einfo "If you want jdom support for jaxen then "
	einfo "please emerge dev-java/jdom first and"
	einfo "re-emerge dev-java/jaxen.  Sorry for the"
	einfo "inconvenience, this is to break out of the"
	einfo "circular dependencies."
	einfo ""
}
