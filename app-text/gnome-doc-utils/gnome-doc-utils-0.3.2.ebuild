# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-doc-utils/gnome-doc-utils-0.3.2.ebuild,v 1.1 2005/08/18 21:52:23 allanonjl Exp $

inherit python gnome2

DESCRIPTION="A collection of documentation utilities for the Gnome project"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.8
	>=dev-lang/python-2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"

USE_DESTDIR="1"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
}

pkg_postinst() {
	python_mod_optimize ${ROOT}/usr/share/xml2po
	gnome2_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup ${ROOT}/usr/share/xml2po
	gnome2_pkg_postrm
}
