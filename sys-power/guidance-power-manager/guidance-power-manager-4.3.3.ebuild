# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/guidance-power-manager/guidance-power-manager-4.3.3.ebuild,v 1.1 2009/11/13 17:51:38 ssuominen Exp $

EAPI=2
KDE_LINGUAS="cs de el en_GB es et fr ga gl is it km ko lt lv ml nb nds nl nn pa
pl pt pt_BR ro ru sk sv tr uk zh_CN zh_TW"
inherit python kde4-base

DESCRIPTION="KDE Power Manager control module"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

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
