# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/modemmanager/modemmanager-0.2_p20091123.ebuild,v 1.1 2009/11/23 15:34:50 dagger Exp $

EAPI=2

inherit eutils

# ModemManager likes itself with capital letters
MY_P=${P/modemmanager/ModemManager}

DESCRIPTION="Modem and mobile broadband management libraries"
HOMEPAGE="http://mail.gnome.org/archives/networkmanager-list/2008-July/msg00274.html"
SRC_URI="http://dev.gentoo.org/~dagger/files/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="net-dialup/ppp"

DEPEND=">=sys-fs/udev-145[extras]
	dev-util/pkgconfig
	dev-util/intltool"

src_configure() {
	econf \
		--disable-more-warnings
}

S=${WORKDIR}/${MY_P/_p20090806/}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
