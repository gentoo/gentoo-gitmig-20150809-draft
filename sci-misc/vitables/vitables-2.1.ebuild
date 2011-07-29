# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/vitables/vitables-2.1.ebuild,v 1.1 2011/07/29 06:17:43 bicatali Exp $

EAPI="2"

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A graphical tool for browsing and editing files in both PyTables and HDF5 formats"
HOMEPAGE="http://vitables.berlios.de/"
SRC_URI="mirror://berlios/vitables/ViTables-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

DEPEND="
	>=dev-python/pytables-2.0
	dev-python/PyQt4[X]"  # FIXME: check if any other useflags are needed
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/ViTables-${PV}"

src_install() {
	dodir /usr/share/icons/hicolor/scalable/apps
	dodir /usr/share/applications
	XDG_DATA_DIRS="${D}/usr/share" distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${P}/examples
		doins -r examples/* || die
	fi

	if use doc; then
		dodoc doc/* || die
	fi
}
