# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/vitables/vitables-2.1.ebuild,v 1.2 2012/04/22 08:00:54 xarthisius Exp $

EAPI="2"

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

MY_PN=ViTables
MY_P=${MY_PN}-${PV}

inherit distutils eutils

DESCRIPTION="A graphical tool for browsing and editing files in both PyTables and HDF5 formats"
HOMEPAGE="http://vitables.org/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="
	dev-python/pytables
	dev-python/PyQt4[X]"  # FIXME: check if any other useflags are needed
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

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
