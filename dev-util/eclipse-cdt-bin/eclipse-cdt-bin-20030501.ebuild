# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-cdt-bin/eclipse-cdt-bin-20030501.ebuild,v 1.1 2003/05/02 19:24:51 latexer Exp $

S=${WORKDIR}/eclipse
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://download.eclipse.org/tools/cdt/downloads/cdt/cdt1_1/org.eclipse.cdt-200305011510.linux.gtk_1.1.0.bin.dist.zip"

SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~sparc"

DEPEND="=dev-util/eclipse-platform-bin-2.1*"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_install () {
	dodir /opt/eclipse/plugins
	dodir /opt/eclipse/features

	cp -dpR plugins/org.eclipse.cdt* ${D}/opt/eclipse/plugins/
	cp -dpR features/org.eclipse.cdt* ${D}/opt/eclipse/features/

	dohtml plugins/org.eclipse.cdt.core_1.1.0/about.html
}
