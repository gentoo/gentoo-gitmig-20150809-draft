# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakartacommons/jakartacommons-0.4.3.ebuild,v 1.3 2005/04/04 14:58:00 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="jedit plugin: The JakartaCommons plugin provides a single point of dependency for plugins needing to use Apache Jakarta libraries. Currently included are BCEL, commons-collections, and commons-logging."

HOMEPAGE="http://plugins.jedit.org/plugins/?JakartaCommons"
SRC_URI="mirror://sourceforge/jedit-plugins/JakartaCommons-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=app-editors/jedit-4.2
		dev-java/ant"
RDEPEND="dev-java/bcel
		dev-java/commons-collections
		>=dev-java/commons-httpclient-2.0.1
		=dev-java/commons-lang-2.0*
		dev-java/commons-logging
		dev-java/log4j"

S=${WORKDIR}/JakartaCommons

src_unpack() {
	unpack ${A}
	rm -f *.jar
	cd ${S}
	epatch ${FILESDIR}/props.patch
}

src_compile() {
	ant dist -Djedit.install.dir=/usr/share/jedit -Dinstall.dir=. || die "compile failed"
}

src_install() {
	java-pkg_dojar JakartaCommons.jar
	dodir /usr/share/jedit/jars
	dosym /usr/share/${PN}/lib/JakartaCommons.jar /usr/share/jedit/jars/JakartaCommons.jar
	local libs="bcel commons-collections commons-httpclient commons-lang commons-logging log4j"
	for lib in ${libs}; do
		dosym /usr/share/${lib}/lib/${lib}.jar /usr/share/jedit/jars/${lib}.jar
	done
}
