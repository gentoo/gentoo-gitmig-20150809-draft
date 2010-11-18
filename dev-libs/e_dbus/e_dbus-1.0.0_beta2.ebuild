# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/e_dbus/e_dbus-1.0.0_beta2.ebuild,v 1.1 2010/11/18 14:14:59 tommy Exp $

EAPI="2"

MY_P=${P/_beta/.beta}

inherit enlightenment

DESCRIPTION="Enlightenment's (Ecore) integration to DBus"
SRC_URI="http://download.enlightenment.org/releases/${MY_P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="bluetooth +connman +hal +libnotify ofono static-libs ukit"

RDEPEND=">=dev-libs/eina-1.0.0_beta
	>=dev-libs/ecore-1.0.0_beta
	sys-apps/dbus
	libnotify? ( >=media-libs/evas-1.0.0_beta )
	hal? ( sys-apps/hal )
	ukit? ( sys-power/upower sys-fs/udisks )
"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${MY_P}

src_configure() {
	MY_ECONF="
	$(use_enable bluetooth ebluez)
	$(use_enable connman econnman)
	$(use_enable doc)
	$(use_enable hal ehal)
	$(use_enable libnotify enotify)
	$(use_enable ofono eofono)
	$(use_enable ukit eukit)
	"
	enlightenment_src_configure
}
