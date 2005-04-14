# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnome-ppp/gnome-ppp-0.3.19.ebuild,v 1.3 2005/04/14 20:29:35 mrness Exp $

inherit gnome2 eutils

MAJOR_V=${PV%.[0-9]*}

DESCRIPTION="A GNOME 2 WvDial frontend"
HOMEPAGE="http://www.gnome-ppp.org/"
SRC_URI="http://www.gnome-ppp.org/download/${MAJOR_V}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=net-dialup/wvdial-1.53-r1
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libglade-2.4
	>=x11-libs/gtk+-2.4"

DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool
	${RDEPEND}"

USE_DESTDIR="1"

src_install() {
	gnome2_src_install top_builddir=${S}
}
