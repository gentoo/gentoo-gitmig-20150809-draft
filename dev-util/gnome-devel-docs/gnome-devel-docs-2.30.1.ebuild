# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnome-devel-docs/gnome-devel-docs-2.30.1.ebuild,v 1.4 2011/11/06 02:39:02 tetromino Exp $

inherit gnome2

DESCRIPTION="Documentation for developing for the GNOME desktop environment"
HOMEPAGE="http://developer.gnome.org/"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

# FIXME: Find a better fix for the failure with parallel install.
# It occurs when a thread starts a mkdir, then it's stopped
# (during the mkdir), and then an other thread try to create the same dir.
# -> when the first thread continue, it tries to create a dir already created
# by the second.
# Have a look to install-sh script, it's commented out for this bug.
RDEPEND=""
DEPEND="dev-util/pkgconfig
	app-text/gnome-doc-utils
	~app-text/docbook-xml-dtd-4.2"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
}

src_install() {
	MAKEOPTS="-j1" gnome2_src_install
}
