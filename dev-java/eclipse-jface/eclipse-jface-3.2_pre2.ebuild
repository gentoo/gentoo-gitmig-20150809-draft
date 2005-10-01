# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/eclipse-jface/eclipse-jface-3.2_pre2.ebuild,v 1.1 2005/10/01 23:55:46 compnerd Exp $

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
		  =dev-java/eclipse-core-3*
		  =dev-java/swt-3*
		  dev-java/ant-core
		  app-arch/unzip"

BASE="org.eclipse.rcp.source_3.1.0"
JFACE_PLUGIN="org.eclipse.jface_3.2.0"

src_unpack() {
	unpack ${A}
	mkdir ${S}

	# The eclipse sources are in a messy layout
	local srcdir="${WORKDIR}/eclipse/plugins/${BASE}/src"

	# Pull out the sources
	mkdir -p ${S}/${JFACE_PLUGIN}/src
	unzip ${srcdir}/${JFACE_PLUGIN}/src.zip \
		  -d ${S}/${JFACE_PLUGIN}/src/ &> /dev/null || die "Unable to extract sources"
	cp ${FILESDIR}/build.xml ${S}/${JFACE_PLUGIN}
}

src_compile() {
	local targets="jar"
	use doc && targets="${targets} javadoc"

	cd ${S}/${JFACE_PLUGIN}
	ant -Dproject.name="org.eclipse.jface" \
		-Dpackage.name="org.eclipse.jface.*" \
		-Dclasspath=$(java-config -p eclipse-core-3,swt-3) \
		${targets} || die "Unable to build JFACE"
}

src_install() {
	java-pkg_dojar ${S}/${JFACE_PLUGIN}/dist/org.eclipse.jface.jar

	if use doc ; then
		java-pkg_dohtml ${S}/${JFACE_PLUGIN}/dist/docs/*
	fi
}
