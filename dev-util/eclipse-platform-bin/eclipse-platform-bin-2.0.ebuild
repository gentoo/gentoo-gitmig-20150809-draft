# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-platform-bin/eclipse-platform-bin-2.0.ebuild,v 1.1 2002/07/13 23:59:04 karltk Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://64.38.198.171/downloads/drops/R-2.0-200206271835/eclipse-platform-2.0-linux-gtk.zip"
LICENSE="CPL-1.0"
SLOT="2"
KEYWORDS="x86"
DEPEND=">=virtual/jdk-1.2
	=x11-libs/gtk+-2.0*"
RDEPEND="$DEPEND"
S=${WORKDIR}/eclipse

src_install () {
	dodir /opt/eclipse

	cp -dpR features install.ini libXm.so.2 eclipse \
		icon.xpm libXm.so libXm.so.2.1 plugins startup.jar \
		${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*

	dodir /etc/env.d
	echo "LDPATH=/opt/eclipse" > ${D}/etc/env.d/20eclipse
}
