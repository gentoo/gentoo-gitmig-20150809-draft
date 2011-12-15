# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.8.0.ebuild,v 1.7 2011/12/15 22:52:33 dilfridge Exp $

EAPI=3
PYTHON_DEPEND="2:2.6"
DISTUTILS_SRC_TEST=setup.py
KDE_HANDBOOK=optional
inherit kde4-base distutils

DESCRIPTION="Touchpad configuration and management tool for KDE"
HOMEPAGE="http://pypi.python.org/pypi/synaptiks"
SRC_URI="mirror://pypi/s/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +upower"

RDEPEND="|| ( >=dev-lang/python-2.7 dev-python/argparse )
	>=dev-python/PyQt4-4.7
	>=dev-python/pyudev-0.8[pyqt4]
	dev-python/setuptools
	$(add_kdebase_dep pykde4)
	$(add_kdebase_dep kdesdk-scripts)
	>=x11-drivers/xf86-input-synaptics-1.3
	>=x11-libs/libXi-1.4
	x11-libs/libXtst
	upower? ( dev-python/dbus-python sys-power/upower )"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	sys-devel/gettext"

pkg_setup() {
	python_set_active_version 2
}

src_configure() { :; };

src_test() {
	distutils_src_test
}

src_install() {
	distutils_src_install
}
