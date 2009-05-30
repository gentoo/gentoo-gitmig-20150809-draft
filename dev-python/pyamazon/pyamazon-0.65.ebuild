# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyamazon/pyamazon-0.65.ebuild,v 1.1 2009/05/30 16:22:03 ssuominen Exp $

EAPI=2
inherit eutils multilib python

DESCRIPTION="A Python wrapper for the Amazon web API."
HOMEPAGE="http://www.josephson.org/projects/pyamazon"
SRC_URI="http://www.josephson.org/projects/pyamazon/files/pyamazon-0.65.zip"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

pkg_setup() {
	python_version
	dest=/usr/$(get_libdir)/python${PYVER}/site-packages
}

src_prepare() {
	edos2unix ${PN}/amazon.py
}

src_install() {
	insinto ${dest}
	doins ${PN}/amazon.py || die "doins failed"
}

pkg_postinst() {
	python_mod_compile ${dest}/amazon.py
}

pkg_postrm() {
	python_mod_cleanup
}
