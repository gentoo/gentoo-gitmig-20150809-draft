# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-cdt-bin/eclipse-cdt-bin-20020704.ebuild,v 1.1 2002/07/13 23:59:04 karltk Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://download.eclipse.org/tools/cdt/downloads/cdt/20020704-CDT-initial.zip"
LICENSE="CPL-1.0"
SLOT="2"
KEYWORDS="x86"
DEPEND="=dev-eclipse/eclipse-platform-bin-2.0*"
RDEPEND="$DEPEND"
S=${WORKDIR}/eclipse

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack 20020704-CDT-initial.zip
}

src_install () {
	dodir /opt/eclipse/plugins

	cp -dpR org.eclipse.cdt* ${D}/opt/eclipse/plugins/

	dohtml org.eclipse.cdt.core/about.html
}
