# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kunststoff-bin/kunststoff-bin-2.0.1.ebuild,v 1.4 2004/11/03 11:35:34 axxo Exp $

inherit java-pkg

DESCRIPTION="A famous Java Look & Feel from incors.org"
HOMEPAGE="http://www.incors.org"
SRC_URI="http://www.incors.org/${PN/-bin}-${PV//./_}.zip"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.3"
S=${WORKDIR}

src_compile() { :; }

src_install() {
	java-pkg_dojar *.jar
}
