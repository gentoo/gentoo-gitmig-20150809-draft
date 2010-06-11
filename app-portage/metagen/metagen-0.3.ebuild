# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/metagen/metagen-0.3.ebuild,v 1.9 2010/06/11 21:52:45 arfrever Exp $

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
	dodir $(python_get_sitedir)/metagen
	dodir /usr/bin
	cp metagen "${D}"$(python_get_sitedir)/metagen/
	dosym "${D}"$(python_get_sitedir)/metagen/metagen /usr/bin/metagen
	doman metagen.1.gz
}
