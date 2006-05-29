# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/taxbird/taxbird-0.7.ebuild,v 1.1 2006/05/29 08:01:09 wrobel Exp $

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
dev-util/guile"

src_compile() {

	econf || die "Configure failed!"
	emake || die "Make failed!"

}

src_install() {

	dodoc README*

	einstall || die "Installation failed!"

}
