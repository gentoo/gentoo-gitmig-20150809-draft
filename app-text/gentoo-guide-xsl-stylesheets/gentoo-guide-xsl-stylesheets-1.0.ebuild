# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/gentoo-guide-xsl-stylesheets/gentoo-guide-xsl-stylesheets-1.0.ebuild,v 1.2 2001/03/26 00:55:53 achim Exp $

S=${WORKDIR}
DESCRIPTION="XSLT Styleshhets for Gentoo-Guide to HTML or DOCBOOK transformation"

DEPEND=">=app-text/sgml-common-0.6.1"


src_install () {

    cd ${FILESDIR}
    insinto /usr/share/sgml/gentoo/guide/xsl/html
    doins html/*.{xsl,css}
    insinto /usr/share/sgml/gentoo/guide/xsl/docbook
    doins docbook/*.xsl

}

