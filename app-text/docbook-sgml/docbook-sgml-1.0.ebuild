# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml/docbook-sgml-1.0.ebuild,v 1.5 2001/06/24 02:20:30 achim Exp $

A=""
S=${WORKDIR}/${P}
DESCRIPTION="A helper package for sgml docbook"

RDEPEND="app-text/sgml-common app-text/openjade
	>=app-text/docbook-dsssl-stylesheets-1.64
	>=app-text/docbook-sgml-utils-0.6.6
	=app-text/docbook-sgml-dtd-3.0
	=app-text/docbook-sgml-dtd-3.1
	=app-text/docbook-sgml-dtd-4.0
	=app-text/docbook-sgml-dtd-4.1"

