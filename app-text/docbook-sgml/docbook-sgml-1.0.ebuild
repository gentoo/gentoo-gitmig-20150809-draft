# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml/docbook-sgml-1.0.ebuild,v 1.13 2002/12/31 04:36:55 satai Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A helper package for sgml docbook"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

RDEPEND="app-text/sgml-common app-text/openjade
	>=app-text/docbook-dsssl-stylesheets-1.64
	>=app-text/docbook-sgml-utils-0.6.6
	=app-text/docbook-sgml-dtd-3.0-r1
	=app-text/docbook-sgml-dtd-3.1-r1
	=app-text/docbook-sgml-dtd-4.0-r1
	=app-text/docbook-sgml-dtd-4.1-r1"
