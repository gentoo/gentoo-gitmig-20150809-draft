# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnome-ppp/gnome-ppp-0.3.17.ebuild,v 1.1 2004/11/19 21:48:03 mrness Exp $

inherit gnome2 eutils

DESCRIPTION="A GNOME 2 WvDial frontend"
HOMEPAGE="http://www.gnome-ppp.org/"
LICENSE="GPL-2"

MAJOR_V=${PV%.[0-9]*}
SRC_URI="http://www.gnome-ppp.org/download/${MAJOR_V}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=net-dialup/wvdial-1.53-r1
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libglade-2.4
	>=x11-libs/gtk+-2.4"

DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	${RDEPEND}"

USE_DESTDIR="1"

src_install() {
	gnome2_src_install top_builddir=${S}
}
