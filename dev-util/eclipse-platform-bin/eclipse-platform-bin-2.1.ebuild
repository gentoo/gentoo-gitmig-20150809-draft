# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-platform-bin/eclipse-platform-bin-2.1.ebuild,v 1.2 2003/04/27 06:29:40 tberman Exp $

S=${WORKDIR}/eclipse
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://download.eclipse.org/downloads/drops/R-2.1-200303272130/eclipse-platform-2.1-linux-gtk.zip"

SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~sparc"

DEPEND=">=virtual/jdk-1.2
	=x11-libs/gtk+-2*"

src_install () {
	dodir /opt/eclipse

	cp -dpR features install.ini eclipse icon.xpm plugins startup.jar \
		${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*

	insinto /usr/share/gnome/apps/Development
	doins ${FILESDIR}/eclipse.desktop

	dodir /etc/env.d
	echo "LDPATH=/opt/eclipse" > ${D}/etc/env.d/20eclipse
}
