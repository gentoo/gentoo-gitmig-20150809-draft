# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/octopus/octopus-3.0.1.ebuild,v 1.1 2005/01/22 17:28:32 luckyduck Exp $

inherit java-pkg

MY_PV=${PV//./-}
MY_PV=${MY_PV/-/.}
DESCRIPTION="A Java-based Extraction, Transformation, and Loading (ETL) tool. It
may connect to any JDBC data sources and perform transformations defined in an
XML file."
SRC_URI="http://download.forge.objectweb.org/${PN}/${PN}-${MY_PV}.src.tar.gz
	mirror://gentoo/${PN}-xmls-${PV}.tar.bz2"
HOMEPAGE="http://octopus.objectweb.org"
LICENSE="LGPL-2.1"
SLOT="3.0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	source?( app-arch/zip )
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/xerces-2.6
	>=dev-java/log4j-1.2.8
	>=dev-java/rhino-1.6.1
	>=dev-java/fop-0.20.5
	>=dev-db/hsqldb-1.7.2.4"

S=${WORKDIR}/${PN}-3.0/Octopus-src

src_unpack() {
	unpack ${A}

	mv xmls ${S}/modules/Octopus

	cd ${S}/modules
	cp ${FILESDIR}/${P}-gentoo-build.xml build.xml
}

src_compile() {
	cd ${S}/modules

	local antflags="jar-all"
	use doc && antflags="${antflags} docs-all"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use source && antflags="${antflags} sourcezip-all"
	ant ${antflags} || die "failed to build"
}

src_install() {
	dodoc ChangeLog.txt LICENSE.txt ReleaseNotes.txt

	cd ${S}/modules
	java-pkg_dojar dist/*.jar

	if use source; then
		dodir /usr/share/doc/${PF}/source
		cp dist/*-src.zip ${D}usr/share/doc/${PF}/source
	fi
	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}
