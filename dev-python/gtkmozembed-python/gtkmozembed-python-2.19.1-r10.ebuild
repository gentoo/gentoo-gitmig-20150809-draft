# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gtkmozembed-python/gtkmozembed-python-2.19.1-r10.ebuild,v 1.4 2009/01/06 14:14:02 neurogeek Exp $

EAPI="1"

G_PY_PN="gnome-python-extras"

inherit confutils gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2
	mirror://gentoo/${G_PY_PN}-${PV}-split.patch.gz"

DESCRIPTION="Python bindings for the GtkMozEmbed Gecko library"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 -sparc ~x86"
IUSE="doc firefox seamonkey +xulrunner"

RDEPEND="xulrunner? ( =net-libs/xulrunner-1.9* )
	!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )
	!xulrunner? ( !firefox? ( seamonkey? ( =www-client/seamonkey-1* ) ) )"
DEPEND="${RDEPEND}"

pkg_setup() {
	gnome-python-common_pkg_setup

	confutils_require_any "firefox" "seamonkey" "xulrunner"

	if use xulrunner; then
		G2CONF="${G2CONF} --with-gtkmozembed=xulrunner"
	elif use firefox; then
		G2CONF="${G2CONF} --with-gtkmozembed=firefox"
	elif use seamonkey; then
		G2CONF="${G2CONF} --with-gtkmozembed=seamonkey"
	fi
}

src_unpack() {
	gnome-python-common_src_unpack

	# change mozilla to seamonkey
	sed -e 's:1.2b):1.0.0):;s:mozilla):seamonkey):' -i configure.ac

	epatch "${WORKDIR}/${G_PY_PN}-${PV}-split.patch"
	eautoreconf
}
