# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gdesklets-core/gdesklets-core-0.33.1.ebuild,v 1.2 2005/06/27 02:29:02 nixphoeni Exp $

inherit gnome2 eutils

MY_PN="gDesklets"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNOME Desktop Applets: core library for the desktop applets"
SRC_URI="http://www.pycage.de/download/gdesklets/${MY_P}.tar.bz2 \
		 http://www.pycage.de/develbook/develbook.tar.bz2 "
HOMEPAGE="http://gdesklets.gnomedesktop.org"
LICENSE="GPL-2"

SLOT="0"
IUSE="doc"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"

RDEPEND=">=dev-lang/python-2.3
	>=dev-libs/glib-2
	>=gnome-base/librsvg-2
	>=gnome-base/gconf-2
	>=gnome-base/libgtop-2.6
	>=dev-python/pygtk-2.4
	>=dev-python/gnome-python-2.6
	>=gnome-base/libgnomeui-2.2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	unpack ${A}
	# Fix the TilingImage.py bug
	cd ${S}/utils
	sed -i -e "s/gnomevfs.exists(uri)/gnomevfs.exists(gnomevfs.URI(uri))/" \
		TilingImage.py

}

src_install() {

	gnome2_src_install
	# Symlink the binaries from /usr/lib/gdesklets
	# to /usr/bin
	dosym /usr/lib/gdesklets/gdesklets-migration-tool \
		  /usr/bin/gdesklets-migration-tool
	dosym /usr/lib/gdesklets/gdesklets-daemon \
		  /usr/bin/gdesklets-daemon
	dosym /usr/lib/gdesklets/gdesklets-logview \
		  /usr/bin/gdesklets-logview
	dosym /usr/lib/gdesklets/gdesklets-shell \
		  /usr/bin/gdesklets-shell

	# Install the Developer's book documentation
	use doc && dohtml -r ${WORKDIR}/develbook/*

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
	einfo "through Applications->Accessories->gDesklets"
	echo ""
	ewarn "If you are migrating from a previous version of "
	ewarn "gDesklets, please convert your settings with - "
	ewarn "         /usr/bin/gdesklets-migration-tool "
	echo ""

	# This stuff is important, especially the migration-tool
	# information which flies by on an update.
	epause 9

}

