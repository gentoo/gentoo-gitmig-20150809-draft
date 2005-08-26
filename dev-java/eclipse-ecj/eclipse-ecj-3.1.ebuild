# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/eclipse-ecj/eclipse-ecj-3.1.ebuild,v 1.2 2005/08/26 18:34:09 karltk Exp $

inherit eutils java-pkg

DESCRIPTION="Eclipse Compiler for Java"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://www.gentoo.org/~karltk/projects/java/distfiles/${P}-gentoo.tar.bz2"
LICENSE="EPL-1.0"
KEYWORDS="~x86"
SLOT="3.1"
RDEPEND=">=virtual/jre-1.4"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.4
	dev-java/ant"

src_compile() {
	ant || die "Failed to compile ecj.jar"
}

src_install() {
	java-pkg_dojar ecj.jar || die "ecj.jar not installable"

	exeinto /usr/bin
	doexe ecj-3.1
}

