# Copyright 2004-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jjtraveler/jjtraveler-0.4.3.ebuild,v 1.2 2004/07/20 12:14:31 dholm Exp $

inherit java-pkg

DESCRIPTION="A visitor combinator framework for Java"
HOMEPAGE="http://www.cwi.nl/htbin/sen1/twiki/bin/view/SEN1/ATermLibrary"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/jjtraveler/JJTraveler-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"
S=${WORKDIR}/JJTraveler-${PV}

src_compile() {

	econf || die "Failed to configure"
	emake || die "Failed to make"

	(
		echo "#! /bin/sh"
		echo "java-config -p jjtraveler"
	) > jjtraveler-config
}

src_install() {
	java-pkg_dojar src/jjtraveler-0.4.3.jar

	exeinto /usr/bin
	doexe jjtraveler-config

	dodoc AUTHORS COPYING INSTALL NEWS TODO ChangeLog
}
