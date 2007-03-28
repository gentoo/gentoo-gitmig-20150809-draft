# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gdesklets-core/gdesklets-core-0.35.4.ebuild,v 1.8 2007/03/28 19:16:05 armin76 Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest
inherit gnome2 eutils autotools multilib

MY_PN="gDesklets"
MY_P="${MY_PN}-${PV/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNOME Desktop Applets: Core library for desktop applets"
SRC_URI="http://www.gdesklets.de/files/${MY_P}.tar.bz2 \
		doc? ( mirror://gentoo/gdesklets-develbook-${PV}.tar.bz2 )"
HOMEPAGE="http://www.gdesklets.de"
LICENSE="GPL-2"

SLOT="0"
IUSE="doc"
KEYWORDS="~alpha ~amd64 ia64 ppc ~sparc x86"

RDEPEND=">=dev-lang/python-2.3
	>=dev-libs/glib-2.4
	>=gnome-base/librsvg-2.8
	>=gnome-base/libgtop-2.8.2
	>=dev-python/pygtk-2.4
	>=dev-python/gnome-python-2.6
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

	# Apply patch to correct POTFILES.in so testing will work
	cd ${S}
	epatch ${FILESDIR}/${P}-POTFILES.in.patch

}

src_install() {

	gnome2_src_install

	# Install the gdesklets-control-getid script
	insinto /usr/$(get_libdir)/gdesklets
	insopts -m0555
	doins ${FILESDIR}/gdesklets-control-getid

	# Create a global directory for Displays
	dodir /usr/$(get_libdir)/gdesklets/Displays

	# Install the Developer's Book
	use doc && \
		elog "Installing the Developer's Book into" && \
		elog "/usr/share/doc/${PF}/html" && \
		dohtml -r ${WORKDIR}/gdesklets-develbook/*

	# Install the man page
	doman ${S}/doc/man/*.1

	# Remove conflicts with x11-misc/shared-mime-info and auto-generated MIME info
	rm -rf ${D}/usr/share/mime/aliases ${D}/usr/share/mime/magic ${D}/usr/share/mime/globs \
		${D}/usr/share/mime/subclasses ${D}/usr/share/mime/XMLnamespaces ${D}/usr/share/mime/mime.cache

}

pkg_postinst() {

	gnome2_pkg_postinst

	echo
	elog "gDesklets Displays are required before the library"
	elog "will be usable. The displays are found in -"
	elog "           x11-plugins/desklet-*"
	elog "at http://www.gdesklets.de, or at http://gdesklets.zencomputer.ca"
	elog
	elog "Next you'll need to start gdesklets using"
	elog "           /usr/bin/gdesklets start"
	elog "If you're using GNOME this can be done conveniently"
	elog "through Applications->Accessories->gDesklets"
	elog
	elog "If you're updating from a version less than 0.35_rc1,"
	elog "you can migrate your desklet configurations by"
	elog "running"
	elog "           /usr/lib/gdesklets/gdesklets-migration-tool"
	elog "after the first time you run gdesklets"
	echo

	# This stuff is important, especially the migration-tool
	# information which flies by on an update.
	epause 9

}
