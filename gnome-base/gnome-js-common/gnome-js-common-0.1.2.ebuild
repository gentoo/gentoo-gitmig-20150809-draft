# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-js-common/gnome-js-common-0.1.2.ebuild,v 1.4 2012/08/13 18:18:48 blueness Exp $

EAPI="3"
GCONF_DEBUG="no"
inherit gnome2

DESCRIPTION="GNOME JavaScript common modules and tests"
HOMEPAGE="http://gnome.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35"
DOCS="ChangeLog"

G2CONF="${G2CONF} --disable-seed --disable-gjs"

src_install() {
	gnome2_src_install

	rm -rf "${ED}"/usr/doc
}
