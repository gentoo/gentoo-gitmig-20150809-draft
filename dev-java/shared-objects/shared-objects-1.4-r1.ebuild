# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/shared-objects/shared-objects-1.4-r1.ebuild,v 1.1 2006/09/12 21:43:45 nelchael Exp $

inherit java-pkg-2

DESCRIPTION="A Java Class implementing a core factory for maximal sharing of arbitrary objects"
HOMEPAGE="http://www.cwi.nl/htbin/sen1/twiki/bin/view/SEN1/ATermLibrary"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/shared-objects/shared-objects-1.4.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="source"

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {

	unpack ${A}
	cp "${FILESDIR}/build.xml" "${S}/"

}

src_compile() {

	eant jar

	(
		echo "#! /bin/sh"
		echo "java-config -p shared-objects-1"
	) > shared-objects-config

}

src_install() {

	java-pkg_dojar shared-objects.jar

	dobin shared-objects-config
	dodoc AUTHORS ChangeLog
	use source && java-pkg_dosrc "${S}/shared"

}
