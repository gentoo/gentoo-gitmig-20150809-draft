# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/eclipse-core/eclipse-core-3.2_pre2.ebuild,v 1.1 2005/10/01 23:49:18 compnerd Exp $

inherit java-pkg

MY_DMF="S-3.2M2-200509231000"
MY_VERSION="3.2M2"

DESCRIPTION="Core Runtime Utilities for Eclipse"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/${MY_DMF}/eclipse-RCP-SDK-${MY_VERSION}-linux-gtk.tar.gz"

LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
SLOT="3"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
		  =dev-java/eclipse-osgi-3*
		  dev-java/ant-core
		  app-arch/unzip"

BASE="org.eclipse.rcp.source_3.1.0"
CORE_RUNTIME_PLUGIN="org.eclipse.core.runtime_3.1.0"
CORE_COMMANDS_PLUGIN="org.eclipse.core.commands_3.2.0"
CORE_EXPRESSIONS_PLUGIN="org.eclipse.core.expressions_3.1.0"

src_unpack() {
	unpack ${A}
	mkdir ${S}

	# The eclipse sources are in a messy layout
	local srcdir="${WORKDIR}/eclipse/plugins/${BASE}/src"

	# Pull out the sources
	mkdir -p ${S}/${CORE_RUNTIME_PLUGIN}/src
	unzip ${srcdir}/${CORE_RUNTIME_PLUGIN}/src.zip \
		  -d ${S}/${CORE_RUNTIME_PLUGIN}/src/ &> /dev/null || die "Unable to extract sources"
	cp ${FILESDIR}/build.xml ${S}/${CORE_RUNTIME_PLUGIN}

	mkdir -p ${S}/${CORE_COMMANDS_PLUGIN}/src
	unzip ${srcdir}/${CORE_COMMANDS_PLUGIN}/src.zip \
		  -d ${S}/${CORE_COMMANDS_PLUGIN}/src/ &> /dev/null || die "Unable to extract sources"
	cp ${FILESDIR}/build.xml ${S}/${CORE_COMMANDS_PLUGIN}

	mkdir -p ${S}/${CORE_EXPRESSIONS_PLUGIN}/src
	unzip ${srcdir}/${CORE_EXPRESSIONS_PLUGIN}/src.zip \
		  -d ${S}/${CORE_EXPRESSIONS_PLUGIN}/src/ &> /dev/null || die "Unable to extract sources"
	cp ${FILESDIR}/build.xml ${S}/${CORE_EXPRESSIONS_PLUGIN}
}

src_compile() {
	local targets="jar"
	use doc && targets="${targets} javadoc"

	cd ${S}/${CORE_RUNTIME_PLUGIN}
	ant -Dproject.name="org.eclipse.core.runtime" \
		-Dpackage.name="org.eclipse.core.runtime.*" \
		-Dclasspath=$(java-config -p eclipse-osgi-3) \
		${targets} || die "Unable to build CORE_RUNTIME"

	local runtime=${S}/${CORE_RUNTIME_PLUGIN}/dist/org.eclipse.core.runtime.jar

	cd ${S}/${CORE_COMMANDS_PLUGIN}
	ant -Dproject.name="org.eclipse.core.commands" \
		-Dpackage.name="org.eclipse.core.commands.*" \
		-Dclasspath=$(java-config -p eclipse-osgi-3):${runtime} \
		${targets} || die "Unable to build CORE_COMMANDS"

	cd ${S}/${CORE_EXPRESSIONS_PLUGIN}
	ant -Dproject.name="org.eclipse.core.expressions" \
		-Dpackage.name="org.eclipse.core.expressions.*" \
		-Dclasspath=$(java-config -p eclipse-osgi-3):${runtime} \
		${targets} || die "Unable to build CORE_EXPRESSIONS"
}

src_install() {
	java-pkg_dojar ${S}/${CORE_RUNTIME_PLUGIN}/dist/org.eclipse.core.runtime.jar
	java-pkg_dojar ${S}/${CORE_COMMANDS_PLUGIN}/dist/org.eclipse.core.commands.jar
	java-pkg_dojar ${S}/${CORE_EXPRESSIONS_PLUGIN}/dist/org.eclipse.core.expressions.jar

	if use doc ; then
		java-pkg_dohtml ${S}/${CORE_RUNTIME}/dist/docs/*
		java-pkg_dohtml ${S}/${CORE_COMMANDS_PLUGIN}/dist/docs/*
		java-pkg_dohtml ${S}/${CORE_EXPRESSIONS_PLUGIN}/dist/docs/*
	fi
}
