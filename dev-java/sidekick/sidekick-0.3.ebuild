# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sidekick/sidekick-0.3.ebuild,v 1.2 2004/10/20 07:58:26 absinthe Exp $

inherit java-pkg eutils

DESCRIPTION="jedit plugin: The SideKick plugin provides a framework for high-level language-specific features"

HOMEPAGE="http://plugins.jedit.org/plugins/?SideKick"
SRC_URI="mirror://sourceforge/jedit-plugins/SideKick-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=app-editors/jedit-4.2
		dev-java/errorlist
		dev-java/ant"
#RDEPEND=""

S=${WORKDIR}/SideKick

src_unpack() {
	unpack ${A}
	rm -f SideKick.jar
	cd ${S}
	epatch ${FILESDIR}/build.xml.patch
	java-pkg_jar-from errorlist
}

src_compile() {
	ant dist -Djedit.install.dir=/usr/share/jedit -Dinstall.dir=. || die "compile failed"
}

src_install() {
	java-pkg_dojar SideKick.jar
	dodir /usr/share/jedit/jars
	dosym /usr/share/${PN}/lib/SideKick.jar /usr/share/jedit/jars/SideKick.jar
}
