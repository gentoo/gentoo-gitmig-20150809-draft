# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-SDK/eclipse-SDK-20021016.ebuild,v 1.5 2003/02/13 11:51:06 vapier Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/M-M20021016-200210161432/eclipse-SDK-M20021016-linux-gtk.zip"

SLOT="0"
LICENSE="CPL-1.0"
KEYWORDS="~x86 -ppc ~sparc"

DEPEND=">=virtual/jdk-1.2
	>=x11-libs/gtk+-2.0*"
S=${WORKDIR}/eclipse

src_install() {
	dodir /opt/eclipse

	cp -dpR features install.ini libXm.so.2 eclipse \
		icon.xpm libXm.so libXm.so.2.1 plugins startup.jar \
		${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*

	dodir /etc/env.d
	echo -e "LDPATH=/opt/eclipse\nPATH=/opt/eclipse\nROOTPATH=/opt/eclipse" > ${D}/etc/env.d/20eclipse
}
