# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-activity-journal/gnome-activity-journal-0.8.0-r1.ebuild,v 1.2 2012/02/08 14:20:17 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit gnome2 distutils gnome2-utils versionator

DIR_PV=$(get_version_component_range 1-2)

DESCRIPTION="Tool for easily browsing and finding files on your computer"
HOMEPAGE="https://launchpad.net/gnome-activity-journal/"
SRC_URI="http://launchpad.net/gnome-activity-journal/${DIR_PV}/${PV}/+download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/gconf-python
	dev-python/pygtk
	>=gnome-extra/zeitgeist-0.8.2"
DEPEND="dev-python/python-distutils-extra"

src_configure() { :; }

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	python_mod_optimize /usr/share/gnome-activity-journal
	gnome2_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup /usr/share/gnome-activity-journal
	gnome2_pkg_postrm
}
