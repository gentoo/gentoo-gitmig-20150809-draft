# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/shared-objects/shared-objects-1.4.ebuild,v 1.7 2005/07/15 16:52:01 axxo Exp $

inherit java-pkg

DESCRIPTION="A Java Class implementing a core factory for maximal sharing of arbitrary objects"
HOMEPAGE="http://www.cwi.nl/htbin/sen1/twiki/bin/view/SEN1/ATermLibrary"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/shared-objects/shared-objects-1.4.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86 ~ppc amd64"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	econf || die "Failed to configure"
	emake || die "Failed to make"
	(
		echo "#! /bin/sh"
		echo "java-config -p shared-objects-1"
	) > shared-objects-config
}

src_install() {
	java-pkg_newjar shared-objects-${PV}.jar ${PN}.jar

	dobin shared-objects-config

	dodoc AUTHORS COPYING ChangeLog INSTALL
}
