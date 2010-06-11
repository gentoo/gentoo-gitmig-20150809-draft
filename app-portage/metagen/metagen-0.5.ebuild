# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/metagen/metagen-0.5.ebuild,v 1.8 2010/06/11 22:10:04 arfrever Exp $

inherit python

DESCRIPTION="metadata.xml generator for ebuilds"
HOMEPAGE="http://abeni.sourceforge.net/metagen.html"
SRC_URI="mirror://sourceforge/abeni/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"

IUSE=""
DEPEND=">=dev-python/jaxml-3.01
	>=dev-lang/python-2.3.3"

src_install() {
	dodir $(python_get_sitedir)/metagen
	dodir /usr/bin
	cp *py test_cli "${D}"$(python_get_sitedir)/metagen/
	dosym "${D}"$(python_get_sitedir)/metagen/metagen.py \
			/usr/bin/metagen
	doman metagen.1.gz
	dodoc docs/*
}

src_test() {
	einfo "Starting tests..."
	python -c "from metagen import metagenerator; metagenerator.do_tests()" \
		|| die "metagen tests failed"
	einfo "Tests completed."
}
