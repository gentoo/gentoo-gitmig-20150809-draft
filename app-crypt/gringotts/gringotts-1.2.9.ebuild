# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-1.2.9.ebuild,v 1.6 2009/10/14 00:54:37 halcy0n Exp $

inherit autotools eutils fdo-mime

DESCRIPTION="Utility that allows you to jot down sensitive data"
HOMEPAGE="http://gringotts.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="suid"

RDEPEND=">=dev-libs/libgringotts-1.2
		 >=x11-libs/gtk+-2.12
		 dev-libs/popt"

DEPEND="${RDEPEND}
		sys-devel/gettext
		dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove deprecation flag, soit compiles with >=GTK+-2.4
	sed -i -e 's:-DGTK_DISABLE_DEPRECATED::g' src/Makefile.am

	# Patch up to install desktop entry correctly
	epatch "${FILESDIR}/${PN}-1.2.8-desktop.patch"
	epatch "${FILESDIR}/${PN}-1.2.8-desktop-entry.patch"

	# Prevent prestripping
	epatch "${FILESDIR}/${PN}-1.2.8-no-strip.patch"

	eautomake
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die

	# The FAQ and README documents shouldn't be gzip'd, as they need to be
	# available in plain format when they are called from the `Help' menu.
	#
	# dodoc FAQ README
	dodoc AUTHORS BUGS ChangeLog TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	if use suid; then
		ewarn "You have installed a suid binary for the \`gringotts' program."
		ewarn "Be aware that this setup may break with some glibc installations"
		ewarn "For more information, see bug #69458 in Gentoo's bugzilla at:"
		ewarn "  http://bugs.gentoo.org/"
	else
		einfo "Changing permissions for the gringotts binary."
		chmod u-s "${ROOT}"/usr/bin/gringotts
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
