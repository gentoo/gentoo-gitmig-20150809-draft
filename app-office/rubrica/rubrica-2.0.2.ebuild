# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/rubrica/rubrica-2.0.2.ebuild,v 1.4 2008/10/13 23:22:38 opfer Exp $

inherit gnome2

MY_PN=${PN}2

DESCRIPTION="A contact database for Gnome"
HOMEPAGE="http://rubrica.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${MY_PN}-${PV}.tar.bz2"
IUSE=""
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-3"
DOCS="AUTHORS ChangeLog CREDITS INSTALL NEWS README TODO"
S=${WORKDIR}/${MY_PN}-${PV}/

RDEPEND="dev-libs/libxml2
	gnome-base/libglade
	>=gnome-base/gconf-2
	x11-libs/libnotify"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
