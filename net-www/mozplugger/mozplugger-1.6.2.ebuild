# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozplugger/mozplugger-1.6.2.ebuild,v 1.4 2005/03/18 16:42:55 seemant Exp $

inherit nsplugins

DESCRIPTION="Streaming media plugin for Mozilla, based on netscape-plugger"
SRC_URI="http://downloads.mozdev.org/mozplugger/${P}.tar.gz"
HOMEPAGE="http://mozplugger.mozdev.org/"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	!virtual/plugger
	|| (
		net-www/mozilla
		www-client/mozilla-bin
		net-www/mozilla-firefox
		www-client/mozilla-firefox-bin
	)"
PROVIDE="virtual/plugger"

src_compile()
{
	cd ${S}
	make linux || die
}

src_install()
{
	cd ${S}

	PLUGIN=/opt/netscape/$PLUGINS_DIR
	dodir $PLUGIN /etc

	insinto /etc
	doins mozpluggerrc

	insinto $PLUGIN
	doins mozplugger.so

	bunzip2 mozplugger.7.bz2
	doman mozplugger.7

	insinto /usr/bin
	dobin mozplugger-helper
	dobin mozplugger-controller

	inst_plugin $PLUGIN/mozplugger.so

	dodoc ChangeLog COPYING README
}
