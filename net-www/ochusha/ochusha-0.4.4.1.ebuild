# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/ochusha/ochusha-0.4.4.1.ebuild,v 1.1 2003/11/05 17:16:52 usata Exp $

IUSE=""

DESCRIPTION="Ochusha - 2ch viewer for GTK+"
HOMEPAGE="http://ochusha.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/6693/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/xft
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	>=dev-libs/libxml2-2.5.0
	gnome-base/libghttp
	sys-libs/zlib
	sys-devel/gettext"
#RDEPEND=""

S=${WORKDIR}/${P}

src_install() {

	einstall || die

	dodoc ABOUT-NLS ACKNOWLEDGEMENT AUTHORS BUGS \
		ChangeLog INSTALL* NEWS README TODO
}
