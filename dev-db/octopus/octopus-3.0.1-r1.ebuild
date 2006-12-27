# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/octopus/octopus-3.0.1-r1.ebuild,v 1.1 2006/12/27 23:13:24 betelgeuse Exp $

inherit versionator java-pkg-2 java-ant-2

MY_PV=${PV//./-}
MY_PV=${MY_PV/-/.}
DESCRIPTION="A Java-based Extraction, Transformation, and Loading (ETL) tool. It may connect to any JDBC data sources and perform transformations defined in an XML file."
SRC_URI="http://download.forge.objectweb.org/${PN}/${PN}-${MY_PV}.src.tar.gz
	mirror://gentoo/${PN}-xmls-${PV}.tar.bz2"
HOMEPAGE="http://octopus.objectweb.org"
LICENSE="LGPL-2.1"
SLOT="3.0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"
# Does not like org.w3c.dom.Node
# from 1.6
RDEPEND="|| ( =virtual/jre-1.4* =virtual/jdk-1.5* )
	>=dev-java/xerces-2.7
	>=dev-java/log4j-1.2.8
	=dev-java/rhino-1.6*
	dev-java/junit
	>=dev-java/ant-core-1.4"

DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.5* )
	${RDEPEND}
	source? ( app-arch/zip )"

TOPDIR="${PN}-$(get_version_component_range 1-2)"
S=${WORKDIR}/${TOPDIR}/Octopus-src

src_unpack() {
	unpack ${A}
	rm -fr ${TOPDIR}/maven

	mv xmls "${S}"/modules/Octopus

	cd "${S}"/modules
	cp ${FILESDIR}/${P}-gentoo-build.xml build.xml
	java-ant_rewrite-classpath build.xml
}

src_compile() {
	cd ${S}/modules

	use source && antflags="${antflags} sourcezip-all"

	deps="xerces-2,rhino-1.6,ant-core,junit,log4j"
	eant jar-all $(use_doc docs-all) ${antflags} \
		-Dgentoo.classpath="$(java-pkg_getjars ${deps})"
}

src_install() {
	dodoc ChangeLog.txt ReleaseNotes.txt

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
