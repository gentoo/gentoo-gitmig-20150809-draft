# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-jdt-bin/eclipse-jdt-bin-2.1.ebuild,v 1.1 2003/04/23 04:09:52 latexer Exp $

S=${WORKDIR}/eclipse
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://download.eclipse.org/downloads/drops/R-2.1-200303272130/eclipse-JDT-2.1.zip"

SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="~x86"

DEPEND="=dev-util/eclipse-platform-bin-2.1*"

src_install () {
	dodir /opt/eclipse

	cp -dpR features plugins ${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*
}
