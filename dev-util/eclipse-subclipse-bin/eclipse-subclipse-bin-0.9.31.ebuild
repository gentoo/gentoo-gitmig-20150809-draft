# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-subclipse-bin/eclipse-subclipse-bin-0.9.31.ebuild,v 1.2 2006/04/14 03:26:34 nichoj Exp $

inherit eclipse-ext

DESCRIPTION="Subversion Integration for Eclipse"
HOMEPAGE="http://subclipse.tigris.org/"
SRC_URI="http://subclipse.tigris.org/update/plugins/org.tigris.subversion.subclipse_${PV}.jar
http://subclipse.tigris.org/update/plugins/org.tigris.subversion.subclipse.core_${PV}.jar
http://subclipse.tigris.org/update/plugins/org.tigris.subversion.subclipse.ui_${PV}.jar"

LICENSE="CPL-1.0"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=dev-util/eclipse-sdk-3*
	dev-util/subversion"

S=${WORKDIR}

src_unpack() {
	local JARFILE=org.tigris.subversion.subclipse_${PV}.jar
	local PLUGINDIR=${S}/features/${JARFILE%.*}
	mkdir -p ${PLUGINDIR}
	cd ${PLUGINDIR}
	unzip -qo "${DISTDIR}/${JARFILE}" || die "Failed unpacking ${JARFILE}"

	JARFILE=org.tigris.subversion.subclipse.core_${PV}.jar
	PLUGINDIR=${S}/plugins/${JARFILE%.*}
	mkdir -p ${PLUGINDIR}
	cd ${PLUGINDIR}
	unzip -qo "${DISTDIR}/${JARFILE}" || die "Failed unpacking ${JARFILE}"

	JARFILE=org.tigris.subversion.subclipse.ui_${PV}.jar
	PLUGINDIR=${S}/plugins/${JARFILE%.*}
	mkdir -p ${PLUGINDIR}
	cd ${PLUGINDIR}
	unzip -qo "${DISTDIR}/${JARFILE}" || die "Failed unpacking ${JARFILE}"
}

src_compile() {
	einfo "${P} is a binary package"
}

src_install () {
	eclipse-ext_require-slot 3 || die "Suitable Eclipse installation not found"

	eclipse-ext_create-ext-layout binary || die "Failed to create layout"
	eclipse-ext_install-features features/* || die "Failed to install features"
	eclipse-ext_install-plugins plugins/* || die "Failed to install plugins"
}
