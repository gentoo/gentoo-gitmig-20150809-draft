# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdiffplugin/jdiffplugin-1.4.2.ebuild,v 1.2 2004/10/20 08:18:36 absinthe Exp $

inherit java-pkg

DESCRIPTION="jedit plugin: JDiffPlugin is a visual diff utility for jEdit."

HOMEPAGE="http://plugins.jedit.org/plugins/?JDiffPlugin"
SRC_URI="mirror://sourceforge/jedit-plugins/JDiffPlugin-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=app-editors/jedit-4.2
		dev-java/ant"
#RDEPEND=""

S=${WORKDIR}/JDiffPlugin

src_unpack() {
	unpack ${A}
	rm -f JDiffPlugin.jar
	cd ${S}
}

src_compile() {
	ant dist -Djedit.install.dir=/usr/share/jedit -Dinstall.dir=. || die "compile failed"
}

src_install() {
	java-pkg_dojar JDiffPlugin.jar
	dodir /usr/share/jedit/jars
	dosym /usr/share/${PN}/lib/JDiffPlugin.jar /usr/share/jedit/jars/JDiffPlugin.jar
}
