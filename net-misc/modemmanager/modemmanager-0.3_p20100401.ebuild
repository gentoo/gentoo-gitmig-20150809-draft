# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/modemmanager/modemmanager-0.3_p20100401.ebuild,v 1.2 2010/07/07 16:55:56 ssuominen Exp $

EAPI="2"

inherit gnome.org eutils

# ModemManager likes itself with capital letters
MY_P=${P/modemmanager/ModemManager}

DESCRIPTION="Modem and mobile broadband management libraries"
HOMEPAGE="http://mail.gnome.org/archives/networkmanager-list/2008-July/msg00274.html"
SRC_URI="http://dev.gentoo.org/~dagger/files/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-libs/glib-2.18
	>=dev-libs/dbus-glib-0.75
	net-dialup/ppp"
DEPEND=">=sys-fs/udev-145[extras]
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

S="${WORKDIR}/${MY_P}"

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
