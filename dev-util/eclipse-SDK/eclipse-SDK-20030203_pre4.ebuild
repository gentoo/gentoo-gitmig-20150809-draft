# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-SDK/eclipse-SDK-20030203_pre4.ebuild,v 1.2 2003/02/13 11:51:11 vapier Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/S-M4-200212181304/eclipse-SDK-M4-linux-gtk.zip"
IUSE=""

SLOT="0"
LICENSE="CPL-1.0"
KEYWORDS="~x86 -ppc ~sparc"

DEPEND=">=virtual/jdk-1.3
	=x11-libs/gtk+-2*"
S=${WORKDIR}/eclipse

src_install() {
	dodir /opt/eclipse

	cp -dpR features install.ini  eclipse \
		icon.xpm plugins startup.jar \
		${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*

	dodir /etc/env.d
	echo -e "LDPATH=/opt/eclipse\nPATH=/opt/eclipse\nROOTPATH=/opt/eclipse" > ${D}/etc/env.d/20eclipse
}
