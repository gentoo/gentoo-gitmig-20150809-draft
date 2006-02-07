# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pybluez/pybluez-0.5.ebuild,v 1.2 2006/02/07 18:25:44 kloeri Exp $

inherit distutils python

DESCRIPTION="Python bindings for Bluez Bluetooth Stack"
HOMEPAGE="http://org.csail.mit.edu/pybluez/"
SRC_URI="http://org.csail.mit.edu/pybluez/release/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=dev-lang/python-2.3
	>=net-wireless/bluez-libs-2.10"

PYTHON_MODNAME="pybluez"

src_install() {
	distutils_src_install

	if use doc; then
		[ -x doc/gendoc ] && doc/gendoc && [ -r doc/bluetooth.html ] && dohtml doc/bluetooth.html
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi

	python_version
	python_mod_compile ${D}/usr/$(get_libdir)/python${PYVER}/site-packages/bluetooth.py
}
