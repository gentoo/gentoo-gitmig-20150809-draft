# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/system-config-printer-kde/system-config-printer-kde-4.4.0.ebuild,v 1.4 2010/03/27 20:48:43 reavertm Exp $

EAPI="2"

KMNAME="kdeadmin"
PYTHON_DEPEND="2"
inherit python kde4-meta

DESCRIPTION="KDE port of Red Hat's Gnome system-config-printer"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="
	>=app-admin/system-config-printer-common-1.1.18
	>=dev-python/pycups-1.9.46
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}
	net-print/cups[dbus]
"

pkg_setup() {
	kde4-meta_pkg_setup
	python_set_active_version 2
}

src_install() {
	kde4-meta_src_install
	python_convert_shebangs -q -r $(python_get_version) "${ED}${PREFIX}/share/apps/${PN}"
}

pkg_postrm() {
	python_mod_cleanup "${PREFIX}share/apps/${PN}"
}
