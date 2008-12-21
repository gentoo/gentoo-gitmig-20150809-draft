# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-user-docs/gnome-user-docs-2.24.1.ebuild,v 1.1 2008/12/21 17:09:46 eva Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="GNOME end user documentation"
HOMEPAGE="http://www.gnome.org/"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.5.6
	>=dev-util/pkgconfig-0.9"
#	test? (
#		~app-text/docbook-xml-dtd-4.1.2
#		~app-text/docbook-xml-dtd-4.3 )"

DOCS="AUTHORS ChangeLog NEWS README"

# Parallel make doesn't always work (bug #135955)
#MAKEOPTS="${MAKEOPTS} -j1"

# Fails to validate, upstream bug #535906
RESTRICT="test"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
}
