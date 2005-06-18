# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gdesklets-core/gdesklets-core-0.35.1.ebuild,v 1.1 2005/06/18 03:35:33 nixphoeni Exp $

inherit gnome2 eutils multilib

MY_PN="gDesklets"
MY_P="${MY_PN}-${PV/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNOME Desktop Applets: core library for the desktop applets"
SRC_URI="http://www.gdesklets.org/releases/${MY_P}.tar.bz2 \
		http://www.pycage.de/develbook/develbook.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org"
LICENSE="GPL-2"

SLOT="0"
IUSE="doc"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

RDEPEND=">=dev-lang/python-2.3
	>=dev-libs/glib-2
	>=gnome-base/librsvg-2
	>=gnome-base/libgtop-2.8.2
	>=dev-python/pygtk-2.4
	>=dev-python/gnome-python-2.6
	>=x11-libs/gtk+-2.2
	>=dev-libs/expat-1.95.8
	>=dev-python/pyxml-0.8.3-r1"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_install() {

	gnome2_src_install

	# Install the gdesklets-control-getid script
	insinto /usr/$(get_libdir)/gdesklets
	insopts -m0555
	doins ${FILESDIR}/gdesklets-control-getid

	# Create a global directory for Displays
	dodir /usr/$(get_libdir)/gdesklets/Displays

	# Install the Developer's book documentation
	use doc && dohtml -r ${WORKDIR}/develbook/*

}

pkg_postinst() {

	gnome2_pkg_postinst

	echo ""
	einfo "gDesklets Displays are required before the library"
	einfo "will be usable. The displays are found in - "
	einfo "           x11-plugins/desklet-*"
	einfo "or at http://gdesklets.gnomedesktop.org"
	echo ""
	einfo "Next you'll need to start gdesklets using"
	einfo "           /usr/bin/gdesklets start"
	einfo "If you're using GNOME this can be done conveniently"
	einfo "through Applications->Accessories->gDesklets"
	echo ""
	ewarn "If you're updating from a version less than 0.35_rc1,"
	ewarn "note that your desklet configurations will be lost."
	echo ""

	# This stuff is important, especially the migration-tool
	# information which flies by on an update.
	epause 9

}
