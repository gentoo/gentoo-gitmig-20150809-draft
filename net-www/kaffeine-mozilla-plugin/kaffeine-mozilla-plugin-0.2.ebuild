# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/kaffeine-mozilla-plugin/kaffeine-mozilla-plugin-0.2.ebuild,v 1.9 2006/01/25 06:31:01 spyderous Exp $

inherit nsplugins

MY_P=${P/-plugin/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Kaffeine Mozilla starter plugin."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${MY_P}.tar.bz2"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=media-video/kaffeine-0.4.3
	|| ( x11-libs/libXaw virtual/x11 )"
DEPEND="${RDEPEND}"

src_compile() {
	econf --prefix=/usr/lib/${PLUGINS_DIR} || die
	emake || die
}

src_install() {
	einstall prefix=${D}/usr/lib/${PLUGINS_DIR%plugins} || die
	dodoc AUTHORS ChangeLog README
}
