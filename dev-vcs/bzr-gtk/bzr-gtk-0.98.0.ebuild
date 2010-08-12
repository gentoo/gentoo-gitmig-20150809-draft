# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr-gtk/bzr-gtk-0.98.0.ebuild,v 1.4 2010/08/12 21:23:05 fauli Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="/${P/_rc/rc}"

DESCRIPTION="A GTK+ interfaces to most Bazaar operations"
HOMEPAGE="http://bazaar-vcs.org/bzr-gtk"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gconf gnome-keyring gpg +sourceview libnotify nautilus"

DEPEND=">=dev-vcs/bzr-1.6_rc1
	<dev-vcs/bzr-2.2.0
	>=dev-python/pygtk-2.8
	nautilus? ( dev-python/nautilus-python )
	>=dev-python/pycairo-1.0"
RDEPEND="${DEPEND}
	gnome-keyring? ( dev-python/gnome-keyring-python )
	gpg? ( app-crypt/seahorse )
	sourceview? (
		dev-python/pygtksourceview
		gconf? ( dev-python/gconf-python )
	)"

S="${WORKDIR}/${MY_P}"

#TODO: src_test

src_install() {
	distutils_src_install

	if use libnotify; then
		insinto /etc/xdg/autostart
		doins bzr-notify.desktop
	fi
}
