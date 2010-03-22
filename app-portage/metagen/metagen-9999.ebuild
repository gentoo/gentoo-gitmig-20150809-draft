# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/metagen/metagen-9999.ebuild,v 1.1 2010/03/22 23:16:35 sping Exp $

inherit git python

DESCRIPTION="metadata.xml generator for ebuilds"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/metagen.git;a=summary"
SRC_URI=""
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/metagen.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE=""
DEPEND=">=dev-python/jaxml-3.01
	>=dev-lang/python-2.3.3"

src_install() {
	python_version
	dodir /usr/lib/python${PYVER}/site-packages/metagen
	dodir /usr/bin
	cp *py test_cli "${D}"/usr/lib/python${PYVER}/site-packages/metagen/
	dosym "${D}"/usr/lib/python${PYVER}/site-packages/metagen/metagen.py \
			/usr/bin/metagen
	doman metagen.1
	dodoc docs/*
}

src_test() {
	einfo "Starting tests..."
	python -c "from metagen import metagenerator; metagenerator.do_tests()" \
		|| die "metagen tests failed"
	einfo "Tests completed."
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
