# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/notecase-pro/notecase-pro-3.5.1.ebuild,v 1.1 2011/11/08 18:35:30 maksbotan Exp $

EAPI="4"

inherit eutils fdo-mime multilib

DESCRIPTION="Hierarchical note taker (binary installation)"
HOMEPAGE="http://www.virtual-sky.com/"

# binary builds
SRC_URI="amd64? ( http://www.virtual-sky.com/get.php?gentoo/notecase_pro-${PV}_amd64.tar.gz )
	x86? ( http://www.virtual-sky.com/get.php?gentoo/notecase_pro-${PV}_x86.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
IUSE=""

DEPEND=""
RDEPEND="
	dev-libs/glib:2
	dev-libs/openssl:0.9.8
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/gtksourceview:2.0
	x11-libs/gdk-pixbuf
	x11-libs/libX11
	x11-libs/pango
	"

RESTRICT="mirror"
QA_PREBUILT="opt/${P}/bin/notecase opt/${P}/$(get_libdir)/*"

S=${WORKDIR}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo "Notecase Pro has just been installed."
	einfo "To unlock advanced features you need to purchase a license key."
	einfo "The key file is installed using 'Help'/'Install License' menu item."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

src_install() {
	exeinto /opt/${P}/bin
	doexe usr/bin/notecase

	insinto /opt/${P}/$(get_libdir)
	doins -r usr/$(get_libdir)/notecase

	insinto /usr/share
	doins -r usr/share/*

	make_wrapper ${PN} /opt/${P}/bin/notecase "" /opt/${P}/$(get_libdir)/
}
