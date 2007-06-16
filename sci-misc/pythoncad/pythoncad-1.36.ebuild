# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/pythoncad/pythoncad-1.36.ebuild,v 1.1 2007/06/16 17:01:34 cedk Exp $

NEED_PYTHON=2.3

inherit distutils versionator

MY_PN="PythonCAD"
MY_PV="DS$(get_major_version)-R$(get_after_major_version)"
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="CAD program written in PyGTK"
HOMEPAGE="http://www.pythoncad.org/"
LICENSE="GPL-2"
SRC_URI="http://www.pythoncad.org/releases/${MY_P}.tar.bz2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-1.99.16"
DEPEND=""

PYTHON_MODNAME=${MY_PN}

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/gtkpycad.png/pythoncad.png/" \
		-e "s/gtkpycad.py/pythoncad/" \
		"pythoncad.desktop" || die "sed failed"
}

src_install() {
	distutils_src_install
	newbin gtkpycad.py pythoncad
	insinto /etc/"${PN}"
	doins prefs.py
	domenu pythoncad.desktop
	insinto /usr/share/pixmaps
	newins gtkpycad.png pythoncad.png
}
