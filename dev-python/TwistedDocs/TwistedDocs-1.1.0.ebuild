# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/TwistedDocs/TwistedDocs-1.1.0.ebuild,v 1.1 2003/10/27 08:21:54 lordvan Exp $

#inherit distutils

DESCRIPTION="collection of servers and clients, which can be used either by developers of new applications or directly. Documentation included."
HOMEPAGE="http://www.twistedmatrix.com/"
SRC_URI="http://twisted.sourceforge.net/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 alpha sparc"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	cd ${S}
	# of course it's documentation!
	doman man/*.[0-9n]
	rm -rf man	# don't dupe the man pages

	dodir /usr/share/doc/${PF}
	cp -r . ${D}/usr/share/doc/${PF}
}
