# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-jdt-bin/eclipse-jdt-bin-2.0.ebuild,v 1.8 2003/09/06 17:28:44 karltk Exp $

S=${WORKDIR}/eclipse
DESCRIPTION="Java Development Tools for Eclipse"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://64.38.198.171/downloads/drops/R-2.0-200206271835/eclipse-JDT-2.0.zip"

SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="x86 sparc "

DEPEND="=dev-util/eclipse-platform-bin-2.0*"

src_install () {
	dodir /opt/eclipse

	cp -dpR features plugins ${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*
}
