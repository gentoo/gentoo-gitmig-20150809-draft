# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/guidance-power-manager/guidance-power-manager-4.4.0.ebuild,v 1.4 2011/01/13 15:11:09 arfrever Exp $

EAPI=3

KDE_LINGUAS="ca ca@valencia cs de el en_GB eo es et fr ga gl hr is it km ko lt
lv ml nb nds nl nn pa pl pt pt_BR ro ru sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc-translations/%lingua_${PN}"
inherit python kde4-base

DESCRIPTION="KDE Power Manager control module"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="
	dev-python/dbus-python
	dev-python/sip
	>=kde-base/pykde4-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	kde4-base_pkg_postinst
	python_mod_optimize xf86misc.py
}

pkg_postrm() {
	kde4-base_pkg_postrm
	python_mod_cleanup xf86misc.py
}
