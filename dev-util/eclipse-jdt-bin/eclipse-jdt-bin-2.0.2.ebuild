# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-jdt-bin/eclipse-jdt-bin-2.0.2.ebuild,v 1.1 2002/12/26 09:37:51 mkennedy Exp $

S=${WORKDIR}/eclipse
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://download.eclipse.org/downloads/drops/R-2.0.2-200211071448/eclipse-JDT-2.0.2.zip"

SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="x86 sparc "

DEPEND="=dev-util/eclipse-platform-bin-2.0*"

src_install () {
	dodir /opt/eclipse

	cp -dpR features plugins ${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*
}
