# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/guidance-power-manager/guidance-power-manager-4.4.0.ebuild,v 1.1 2010/02/21 16:03:05 ssuominen Exp $

EAPI=2
KDE_MINIMAL=4.4
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

DEPEND=">=kde-base/pykde4-${KDE_MINIMAL}
	dev-python/dbus-python
	dev-python/sip"

pkg_postinst() {
	kde4-base_pkg_postinst
	python_version
	python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/xf86misc.py
}

pkg_postrm() {
	kde4-base_pkg_postrm
	python_mod_cleanup
}
