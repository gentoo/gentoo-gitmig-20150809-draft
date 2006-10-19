# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gdesklets-core/gdesklets-core-0.34.3-r1.ebuild,v 1.7 2006/10/19 19:25:10 agriffis Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest
inherit gnome2 eutils autotools multilib

MY_PN="gDesklets"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNOME Desktop Applets: core library for the desktop applets"
SRC_URI="http://www.pycage.de/download/gdesklets/${MY_P}.tar.bz2 \
		 doc? ( http://www.pycage.de/develbook/develbook.tar.bz2 )"
HOMEPAGE="http://www.gdesklets.org"
LICENSE="GPL-2"

SLOT="0"
IUSE="doc"
KEYWORDS="alpha amd64 ia64 ppc ~sparc x86"

RDEPEND=">=dev-lang/python-2.3
	>=dev-libs/glib-2
	>=gnome-base/librsvg-2
	>=gnome-base/gconf-2
	>=gnome-base/libgtop-2.8.2
	>=dev-python/pygtk-2.4
	>=dev-python/gnome-python-2.6.1
	>=dev-python/gnome-python-extras-2.10.2
	>=gnome-base/libgnomeui-2.2
	>=dev-libs/expat-1.95.8
	>=dev-python/pyxml-0.8.3-r1"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {

	unpack ${A}

	# Fix up for Daylight Savings Time
	cd ${S} && \
		epatch ${FILESDIR}/dst-fix-0.34.3.patch

}

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

	# Remove conflicts with x11-misc/shared-mime-info and auto-generated MIME info
	rm -rf ${D}/usr/share/mime/aliases ${D}/usr/share/mime/magic ${D}/usr/share/mime/globs \
		${D}/usr/share/mime/subclasses ${D}/usr/share/mime/XMLnamespaces ${D}/usr/share/mime/mime.cache

}

pkg_postinst() {

	gnome2_pkg_postinst

	echo
	einfo "gDesklets Displays are required before the library"
	einfo "will be usable. The displays are found in -"
	einfo "           x11-plugins/desklet-*"
	einfo "or at http://gdesklets.gnomedesktop.org"
	echo
	einfo "Next you'll need to start gdesklets using"
	einfo "           /usr/bin/gdesklets start"
	einfo "If you're using GNOME this can be done conveniently"
	einfo "through Applications->Accessories->gDesklets"
	echo

	# This stuff is important, especially the migration-tool
	# information which flies by on an update.
	epause 9

}
