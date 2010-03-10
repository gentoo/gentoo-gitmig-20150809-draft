# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/pythoncad/pythoncad-1.37.ebuild,v 1.1 2010/03/10 23:13:23 cedk Exp $

NEED_PYTHON=2.3

inherit eutils distutils versionator

MY_PN="PythonCAD"
MY_PV="DS$(get_major_version)-R$(get_after_major_version)"
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="CAD program written in PyGTK"
HOMEPAGE="http://www.pythoncad.org/"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/pythoncad/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-1.99.16"
DEPEND=""

PYTHON_MODNAME=${MY_PN}

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-png.patch"

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
