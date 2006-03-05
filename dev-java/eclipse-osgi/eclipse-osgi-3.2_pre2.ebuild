# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/eclipse-osgi/eclipse-osgi-3.2_pre2.ebuild,v 1.2 2006/03/05 01:18:55 compnerd Exp $

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
		  dev-java/ant-core
		  app-arch/unzip"

BASE="org.eclipse.rcp.source_3.1.0"
OSGI_PLUGIN="org.eclipse.osgi_3.2.0"

src_unpack() {
	unpack ${A}
	mkdir ${S}

	# The eclipse sources are in a messy layout
	local srcdir="${WORKDIR}/eclipse/plugins/${BASE}/src"

	# Pull out the sources
	mkdir -p ${S}/${OSGI_PLUGIN}/src
	unzip ${srcdir}/${OSGI_PLUGIN}/src.zip -d ${S}/${OSGI_PLUGIN}/src/ &> /dev/null || die "Unable to extract sources"
	cp ${FILESDIR}/build.xml ${S}/${OSGI_PLUGIN}
}

src_compile() {
	local targets="jar"
	use doc && targets="${targets} javadoc"

	cd ${S}/${OSGI_PLUGIN}
	ant -Dproject.name=org.eclipse.osgi \
		-Dpackage.name="org.eclipse.osgi.*" ${targets} || die "Build failed"
}

src_install() {
	java-pkg_dojar ${S}/${OSGI_PLUGIN}/dist/org.eclipse.osgi.jar || die "Failed to install jars"

	if use doc ; then
		java-pkg_dohtml -r ${S}/${OSGI_PLUGIN}/dist/doc/* || die "Failed to install docs"
	fi
}
