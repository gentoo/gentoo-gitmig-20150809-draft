# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/minml2/minml2-0.3.ebuild,v 1.1 2004/12/04 17:20:19 karltk Exp $

inherit eutils java-pkg

DESCRIPTION="Small footprint namespace aware XML parser"
SRC_URI="http://www.wilson.co.uk/xml/MinML2-${PV}.zip"
HOMEPAGE="http://wilson.co.uk/xml/minml.htm"
LICENSE="BSD"
SLOT="0.3"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/MinML2.release

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/minml-jikes.patch

	cp ${FILESDIR}/build.xml .
}

src_compile() {
	local antflags="jar"
	if use doc; then
		antflags="${antflags} docs"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/minml2.jar

	dodoc history.txt licence.txt readme.txt
	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}
