# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/metagen/metagen-0.3.ebuild,v 1.8 2010/03/31 13:07:29 idl0r Exp $

inherit python

DESCRIPTION="metadata.xml generator for ebuilds"
HOMEPAGE="http://abeni.sourceforge.net/metagen.html"
SRC_URI="mirror://sourceforge/abeni/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"

IUSE=""
DEPEND=">=dev-python/jaxml-3.01
		>=dev-lang/python-2.3.3"

src_install() {
	python_version
	dodir /usr/lib/python${PYVER}/site-packages/metagen
	dodir /usr/bin
	cp metagen "${D}"/usr/lib/python${PYVER}/site-packages/metagen/
	dosym "${D}"/usr/lib/python${PYVER}/site-packages/metagen/metagen /usr/bin/metagen
	doman metagen.1.gz
}
