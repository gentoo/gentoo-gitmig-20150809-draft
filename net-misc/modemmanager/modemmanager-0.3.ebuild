# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/modemmanager/modemmanager-0.3.ebuild,v 1.3 2011/06/09 02:02:42 sping Exp $

EAPI="2"

inherit gnome.org eutils

# ModemManager likes itself with capital letters
MY_PN="${PN/modemmanager/ModemManager}"

DESCRIPTION="Modem and mobile broadband management libraries"
HOMEPAGE="http://mail.gnome.org/archives/networkmanager-list/2008-July/msg00274.html"
SRC_URI="${SRC_URI//${PN}/${MY_PN}}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-libs/glib-2.18
	>=dev-libs/dbus-glib-0.75
	net-dialup/ppp"
DEPEND="|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-145[extras] )
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	econf \
		--disable-more-warnings \
		--with-udev-base-dir=/etc/udev/ \
		$(use_with doc docs) \
		$(use_with test tests)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
