# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/taxbird/taxbird-0.6.ebuild,v 1.3 2007/01/10 17:47:18 hkbst Exp $

inherit eutils

DESCRIPTION="Taxbird provides a GUI to submit tax forms to the german digital tax project ELSTER."
HOMEPAGE="http://www.taxbird.de/"

SRC_URI="http://www.taxbird.de/download/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="
dev-libs/libgeier
dev-libs/openssl
=gnome-extra/gtkhtml-2*
gnome-base/libgnomeui
sys-devel/gettext
dev-scheme/guile"

src_compile() {

	econf || die "Configure failed!"
	emake || die "Make failed!"

}

src_install() {

	dodoc README*

	einstall || die "Installation failed!"

}
