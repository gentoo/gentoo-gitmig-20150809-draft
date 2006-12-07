# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.3_pre7-r1.ebuild,v 1.2 2006/12/07 23:04:22 flameeyes Exp $

inherit java-pkg-2 java-ant-2 eutils

# TODO use versionator
MY_PV="${PV//_/}"

DESCRIPTION="Programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
SRC_URI="mirror://sourceforge/${PN}/${PN}${MY_PV}source.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
SLOT="0"
IUSE="doc"

RDEPEND=">=virtual/jre-1.5
	=dev-java/gnu-regexp-1*"
DEPEND=">=virtual/jdk-1.5
	doc? (
		=app-text/docbook-xml-dtd-4.3*
		>=app-text/docbook-xsl-stylesheets-1.65.1
		dev-libs/libxslt
	)
	>=dev-java/ant-1.5.4
	=dev-java/gnu-regexp-1*"

S="${WORKDIR}/jEdit"

JEDIT_HOME="/usr/share/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# we need to use our own classpath
	java-ant_rewrite-classpath build.xml

	if use doc; then
		local xsl=$(echo /usr/share/sgml/docbook/xsl-stylesheets-*)
		xsl=${xsl// *}

		local xml=$(echo /usr/share/sgml/docbook/xml-dtd-4.3*)
		xml=${xml// *}

		echo "build.directory=." > build.properties
		echo "docbook.dtd.catalog=${xml}/docbook.cat" >> build.properties
		echo "docbook.xsl=${xsl}" >> build.properties
	fi

	# remove bundled sources
	rm -r gnu/* # gnu-regexp
	# still need to do: bsh, com.microstar.xml.*, org.gjt.*
}
src_compile() {
	# TODO could build more docs, ie userdocs target instead of generate-javadoc
	eant build $(use_doc generate-javadoc) \
		-Dgentoo.classpath=$(java-pkg_getjars gnu-regexp-1):$(java-config --tools)
}

src_install () {
	dodir ${JEDIT_HOME}
	cp -R build/${PN}.jar jars doc macros modes properties startup \
		${D}/usr/share/jedit

	java-pkg_regjar ${JEDIT_HOME}/${PN}.jar

	java-pkg_dolauncher ${PN} --pwd ${JEDIT_HOME} --main org.gjt.sp.jedit.jEdit

	use doc && java-pkg_dojavadoc build/classes/javadoc/api

	make_desktop_entry ${PN} \
		jEdit \
		${JEDIT_HOME}/doc/${PN}.png \
		"Application;Development;"

	# keep the plugin directory
	keepdir ${JEDIT_HOME}/jars
}

pkg_postinst() {
	einfo "The system directory for jEdit plugins is"
	einfo "${JEDIT_HOME}/jars"
}

pkg_postrm() {
	einfo "jEdit plugins installed into /usr/share/jedit/jars"
	einfo "(after installation of jEdit itself) haven't been"
	einfo "removed. To get rid of jEdit completely, you may"
	einfo "want to run"
	einfo ""
	einfo "\trm -r ${JEDIT_HOME}"
}
