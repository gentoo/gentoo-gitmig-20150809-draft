# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-SDK/eclipse-SDK-20020920.ebuild,v 1.3 2002/12/13 18:43:14 cybersystem Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://64.38.198.171/downloads/drops/S-M1-200209201351/eclipse-SDK-I20020920-linux-gtk.zip"
#SRC_URI="http://64.38.198.171/downloads/drops/S-M1-200209201351/eclipse-SDK-I20020920-linux-motif.zip"

SLOT="0"
LICENSE="CPL-1.0"
KEYWORDS="~x86 -ppc"

DEPEND=">=virtual/jdk-1.2
	=x11-libs/gtk+-2.0*"
S=${WORKDIR}/eclipse

src_install() {
	dodir /opt/eclipse

	cp -dpR features install.ini libXm.so.2 eclipse \
		icon.xpm libXm.so libXm.so.2.1 plugins startup.jar \
		${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*

	dodir /etc/env.d
	echo -e "LDPATH=/opt/eclipse\nPATH=/opt/eclipse" > ${D}/etc/env.d/20eclipse
}
