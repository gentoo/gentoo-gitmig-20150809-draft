# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml/xml-0.13.ebuild,v 1.2 2004/10/20 08:02:42 absinthe Exp $

inherit java-pkg eutils

DESCRIPTION="jedit plugin: The XML plugin provides features for editing XML and HTML files."

HOMEPAGE="http://plugins.jedit.org/plugins/?XML"
SRC_URI="mirror://sourceforge/jedit-plugins/XML-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=app-editors/jedit-4.2
		dev-java/errorlist
		dev-java/sidekick
		=dev-java/xerces-2.3*
		dev-java/xml-commons-resolver
		=dev-java/htmlparser-1.3*
		dev-java/ant"
#RDEPEND=""

S=${WORKDIR}/XML

src_unpack() {
	unpack ${A}
	rm -f *.jar
	cd ${S}
	epatch ${FILESDIR}/build.xml.patch
	java-pkg_jar-from errorlist
	java-pkg_jar-from sidekick
	java-pkg_jar-from xerces-2.3
	java-pkg_jar-from xml-commons-resolver
	java-pkg_jar-from htmlparser-1.3
}

src_compile() {
	ant dist -Djedit.install.dir=/usr/share/jedit -Dinstall.dir=. || die "compile failed"
}

src_install() {
	java-pkg_dojar XML.jar
	dodir /usr/share/jedit/jars
	dosym /usr/share/${PN}/lib/XML.jar /usr/share/jedit/jars/XML.jar
	dosym /usr/share/xerces-2.3/lib/xmlParserAPIs.jar /usr/share/jedit/jars/xmlParserAPIs.jar
	dosym /usr/share/xerces-2.3/lib/xercesImpl.jar /usr/share/jedit/jars/xercesImpl.jar
	dosym /usr/share/xml-commons-resolver/lib/xml-commons-resolver.jar /usr/share/jedit/jars/xml-commons-resolver.jar
	dosym /usr/share/htmlparser-1.3/lib/htmlparser.jar /usr/share/jedit/jars/htmlparser.jar
}
