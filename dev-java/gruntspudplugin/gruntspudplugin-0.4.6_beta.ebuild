# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gruntspudplugin/gruntspudplugin-0.4.6_beta.ebuild,v 1.2 2004/11/30 21:39:59 swegener Exp $

inherit java-pkg

DESCRIPTION="jedit plugin: Gruntspud is a graphical CVS client."

HOMEPAGE="http://plugins.jedit.org/plugins/?GruntspudPlugin"
SRC_URI="mirror://sourceforge/jedit-plugins/GruntspudPlugin-${PV/_/-}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=app-editors/jedit-4.2
	>=dev-java/errorlist-1.3.1
	>=dev-java/console-3.7
	>=dev-java/jakartacommons-0.4
	>=dev-java/jdiffplugin-1.3.2
	>=dev-java/xml-0.13
	dev-util/gruntspud
	dev-java/netcomponents-bin
	dev-java/cvslib-bin
	dev-java/plugspud
	dev-java/ant"
#RDEPEND=""

S=${WORKDIR}/GruntspudPlugin

src_unpack() {
	unpack ${A}
	rm -f *.jar
	cd ${S}
	rm -rf build
	java-pkg_jar-from gruntspud
	java-pkg_jar-from plugspud
	java-pkg_jar-from errorlist
	java-pkg_jar-from console
	java-pkg_jar-from jdiffplugin
}

src_compile() {
	ant dist -Djedit.install.dir=/usr/share/jedit -Dinstall.dir=. || die "compile failed"
}

src_install() {
	java-pkg_dojar GruntspudPlugin.jar
	dodir /usr/share/jedit/jars
	dosym /usr/share/${PN}/lib/GruntspudPlugin.jar /usr/share/jedit/jars/GruntspudPlugin.jar
	dosym /usr/share/gruntspud/lib/gruntspud.jar /usr/share/jedit/jars/gruntspud.jar
	dosym /usr/share/plugspud/lib/plugspud.jar /usr/share/jedit/jars/plugspud.jar
	dosym /usr/share/netcomponents-bin/lib/NetComponents.jar /usr/share/jedit/jars/NetComponents.jar
	dosym /usr/share/cvslib-bin/lib/cvslib.jar /usr/share/jedit/jars/cvslib.jar
}
