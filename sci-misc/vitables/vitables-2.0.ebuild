# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/vitables/vitables-2.0.ebuild,v 1.2 2009/06/25 06:09:58 yngwin Exp $

EAPI="2"
NEED_PYTHON="2.5"
# Will work with 2.4 if you manually install the uuid package

inherit distutils eutils

DESCRIPTION="A graphical tool for browsing and editing files in both PyTables and HDF5 formats"
HOMEPAGE="http://vitables.berlios.de/"
SRC_URI="mirror://berlios/vitables/ViTables-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

DEPEND=">=dev-python/pytables-2.0
	dev-python/PyQt4[X]"  # FIXME: check if any other useflags are needed
RDEPEND="${DEPEND}"
S="${WORKDIR}/ViTables-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-doc-examples.patch
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${P}/examples
		doins -r examples/*
	fi

	if use doc; then
		dodoc doc/*
	fi
}
