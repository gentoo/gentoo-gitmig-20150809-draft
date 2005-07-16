# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/oscore-bin/oscore-bin-2.2.4.ebuild,v 1.7 2005/07/16 20:03:55 axxo Exp $

inherit java-pkg

DESCRIPTION="A set of utility-classes useful in any J2EE application"
SRC_URI="https://oscore.dev.java.net/files/documents/725/3716/${P/-bin}.zip"
HOMEPAGE="http://www.opensymphony.com/oscore/"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc amd64"
IUSE="doc"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"
SLOT="0"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	use doc && java-pkg_dohtml -r docs/*
	java-pkg_dojar *.jar
}
