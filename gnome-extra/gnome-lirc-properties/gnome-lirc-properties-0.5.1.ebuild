# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-lirc-properties/gnome-lirc-properties-0.5.1.ebuild,v 1.2 2010/10/10 16:40:12 ssuominen Exp $

EAPI=3

GCONF_DEBUG=no
PYTHON_DEPEND="2:2.4"

inherit gnome2 python

DESCRIPTION="GTK+ based utilty to configure LIRC remotes"
HOMEPAGE="http://live.gnome.org/gnome-lirc-properties"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="policykit"

RDEPEND=">=app-misc/lirc-0.8.4
	>=dev-python/pygtk-2
	policykit? ( sys-auth/polkit )"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.35.0
	dev-util/pkgconfig
	sys-devel/gettext"

# uses AC_PATH_PROG([lircd]), which is in /usr/sbin which is only in the path
# for root
RESTRICT="userpriv"

pkg_setup() {
	G2CONF="$(use_enable policykit policy-kit)"
	DOCS="AUTHORS NEWS README TODO"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	rm -f py-compile
	ln -s $(type -P true) py-compile
	gnome2_src_prepare
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize gnome_lirc_properties
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup gnome_lirc_properties
}
