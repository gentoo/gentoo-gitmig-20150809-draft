# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/taxbird/taxbird-0.10.ebuild,v 1.3 2007/09/08 15:19:06 hanno Exp $

inherit eutils fdo-mime flag-o-matic

DESCRIPTION="Taxbird provides a GUI to submit tax forms to the german digital tax project ELSTER."
HOMEPAGE="http://www.taxbird.de/"

SRC_URI="http://www.taxbird.de/download/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-libs/libgeier
	dev-libs/openssl
	=gnome-extra/gtkhtml-2*
	gnome-base/libgnomeui
	sys-devel/gettext
	dev-scheme/guile"

pkg_setup() {
	if has_version ">=dev-scheme/guile-1.8.0" && ! built_with_use dev-scheme/guile discouraged deprecated; then
		eerror "This package requires dev-scheme/guile with USE=\"discouraged deprecated\"."
		die "Please reemerge dev-scheme/guile with USE=\"discouraged deprecated\"."
	fi

	filter-ldflags -Wl,--as-needed --as-needed
}

src_compile() {
	econf || die "Configure failed!"
	emake || die "Make failed!"
}

src_install() {

	dodoc README*

	einstall || die "Installation failed!"

	# clean out the installed mime files, those get recreated in the pkg_postinst function
	einfo "Deleting mime files in ${D}/usr/share/mime"
	rm -f ${D}/usr/share/mime/{aliases,globs,magic,mime.cache,subclasses,XMLnamespaces}
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
