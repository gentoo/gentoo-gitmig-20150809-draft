# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gdesklets-core/gdesklets-core-0.31.1.ebuild,v 1.1 2004/12/02 05:08:34 obz Exp $

inherit gnome2 eutils

MY_PN="gDesklets"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_PN}-0.31

DESCRIPTION="GNOME Desktop Applets: core library for the desktop applets"
SRC_URI="http://www.pycage.de/download/gdesklets/${MY_P}.tar.bz2"
HOMEPAGE="http://www.pycage.de/software_gdesklets.html"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"

RDEPEND=">=dev-lang/python-2.3
	>=gnome-base/gconf-2
	>=gnome-base/libgtop-2
	>=dev-python/pygtk-2.4
	>=dev-python/gnome-python-2.6
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.2
	>=dev-lang/swig-1.3"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_install() {

	gnome2_src_install
	# there are two links that end up pointing inside the
	# image that we need to fix up here
	dosym /usr/share/gdesklets/gdesklets /usr/bin/gdesklets
	dosym /usr/share/pixmaps/gdesklets.png \
		  /usr/share/gdesklets/data/gdesklets.png

	# install the migration tool
	newbin migration-tool gdesklets-migration-tool

}

pkg_postinst() {

	gnome2_pkg_postinst

	echo ""
	einfo "gDesklets Displays are required before the library"
	einfo "will be usable for you. The displays are found in - "
	einfo "           x11-plugins/desklet-*"
	echo ""
	einfo "Next you'll need to start gdesklets using"
	einfo "           /usr/bin/gdesklets start"
	einfo "If you're using GNOME this can be done conveniently"
	einfo "through Applications->Accessories->gDesklets menu item"
	echo ""
	ewarn "If you are migrating from a previous version of "
	ewarn "gDesklets, please convert your settings, using - "
	ewarn "         /usr/bin/gdesklets-migration-tool "
	echo ""

	# This stuff is important, especially the migration-tool
	# information which flies by on an update.
	epause 9

}

