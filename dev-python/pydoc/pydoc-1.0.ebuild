# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydoc/pydoc-1.0.ebuild,v 1.1 2002/02/10 21:31:43 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Python documentation tool and module"
SRC_URI=""
HOMEPAGE="http://www.lfw.org/python"

RDEPEND="=dev-lang/python-2.0*"

src_install () {
	dodir /usr/lib/python2.0/site-packages

	insinto /usr/lib/python2.0/site-packages
	doins ${FILESDIR}/inspect.py

	exeinto /usr/lib/python2.0/site-packages
	doexe ${FILESDIR}/pydoc.py

	dodir /usr/bin
	dosym /usr/lib/python2.0/site-packages/pydoc.py /usr/bin/pydoc
}
