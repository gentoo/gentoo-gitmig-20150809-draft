# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/kaffeine-mozilla-plugin/kaffeine-mozilla-plugin-0.2.ebuild,v 1.5 2005/03/18 19:48:14 seemant Exp $

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

DEPEND=">=media-video/kaffeine-0.4.3b"
RDEPEND=">=media-video/kaffeine-0.4.3b
	|| ( >=net-www/mozilla-1.6-r1 >=www-client/mozilla-firefox-0.8 )"

src_compile() {
	econf --prefix=/usr/lib/${PLUGINS_DIR} || die
	emake || die
}

src_install() {
	einstall prefix=${D}/usr/lib/${PLUGINS_DIR%plugins} || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README
}
