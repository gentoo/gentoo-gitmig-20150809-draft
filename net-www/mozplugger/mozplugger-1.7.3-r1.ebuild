# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozplugger/mozplugger-1.7.3-r1.ebuild,v 1.1 2006/07/06 21:20:16 chutzpah Exp $

inherit nsplugins

DESCRIPTION="Streaming media plugin for Mozilla, based on netscape-plugger"
SRC_URI="http://downloads.mozdev.org/mozplugger/${P}.tar.gz"
HOMEPAGE="http://mozplugger.mozdev.org/"

KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"
LICENSE="GPL-2"

SLOT="0"
IUSE="firefox"

DEPEND=""
RDEPEND="${DEPEND}
	!sparc? (
		firefox? ( www-client/mozilla-firefox )
		!firefox? ( www-client/seamonkey )
	)
	sparc? ( www-client/mozilla-firefox )"

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
