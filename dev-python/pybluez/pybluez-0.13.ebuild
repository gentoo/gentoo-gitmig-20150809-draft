# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pybluez/pybluez-0.13.ebuild,v 1.1 2007/11/02 01:38:19 hawking Exp $

inherit distutils

DESCRIPTION="Python bindings for Bluez Bluetooth Stack"
HOMEPAGE="http://org.csail.mit.edu/pybluez/"
SRC_URI="http://org.csail.mit.edu/pybluez/release/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="doc examples"

DEPEND=">=net-wireless/bluez-libs-2.10"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="bluetooth"

src_install() {
	distutils_src_install

	if use doc; then
		[ -x doc/gendoc ] && doc/gendoc &&\
				[ -r doc/bluetooth.html ] && dohtml doc/bluetooth.html ||\
				die "failed to generate documentation."
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "doins failed."
	fi
}
