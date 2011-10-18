# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.8.0.ebuild,v 1.2 2011/10/18 22:12:54 dilfridge Exp $

EAPI=3
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

DESCRIPTION="Touchpad configuration and management tool for KDE"
HOMEPAGE="http://pypi.python.org/pypi/synaptiks"
SRC_URI="http://pypi.python.org/packages/source/s/${PN}/${PN}-${PV}.tar.bz2"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook +upower"

RDEPEND="|| ( >=dev-lang/python-2.7 dev-python/argparse )
	>=dev-python/PyQt4-4.7
	>=dev-python/pyudev-0.8[pyqt4]
	>=kde-base/pykde4-4.5
	kde-base/kdesdk-scripts
	>=x11-drivers/xf86-input-synaptics-1.3
	>=x11-libs/libXi-1.4
	x11-libs/libXtst
	upower? ( dev-python/dbus-python sys-power/upower )"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	sys-devel/gettext"

src_install() {
	distutils_src_install --single-version-externally-managed
}
