# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/console/console-3.7.1.ebuild,v 1.2 2004/10/20 05:34:42 absinthe Exp $

inherit java-pkg

DESCRIPTION="jedit plugin: The Console plugin allows jEdit to execute arbitrary commands from an internal shell."

HOMEPAGE="http://plugins.jedit.org/plugins/?Console"
SRC_URI="mirror://sourceforge/jedit-plugins/Console-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=app-editors/jedit-4.2
	>=dev-java/errorlist-1.3.1
	sys-apps/sed
	dev-java/ant"
#RDEPEND=""

S=${WORKDIR}/Console

src_unpack() {
	unpack ${A}
	rm -f Console.jar
	cd ${S}
	sed -e "s/Console/console.Console/" -i console/commando/CommandoDialog.java
	rm -rf build
	java-pkg_jar-from errorlist
}

src_compile() {
	ant dist -Djedit.install.dir=/usr/share/jedit -Dinstall.dir=. || die "compile failed"
}

src_install() {
	java-pkg_dojar Console.jar
	dodir /usr/share/jedit/jars
	dosym /usr/share/${PN}/lib/Console.jar /usr/share/jedit/jars/Console.jar
}
