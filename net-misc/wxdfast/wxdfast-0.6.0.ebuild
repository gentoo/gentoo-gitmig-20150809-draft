# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wxdfast/wxdfast-0.6.0.ebuild,v 1.1 2007/10/19 04:53:14 dirtyepic Exp $

WX_GTK_VER="2.6"

inherit wxwidgets

DESCRIPTION="A multi-treaded cross-platform download manager"
HOMEPAGE="http://dfast.sourceforge.net"
SRC_URI="mirror://sourceforge/dfast/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*"

pkg_setup() {
	need-wxwidgets unicode
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# temporary kludge until all wxGTK versions in tree install wxrc
	if [[ ! -e /usr/bin/wxrc ]]; then
		sed -i -e "/wxrc --version/ s:wxrc:wxrc-${WX_GTK_VER}:" configure
		sed -i -e "/^WXRC/ s:wxrc:wxrc-${WX_GTK_VER}:" Makefile.gcc
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog TODO
}
