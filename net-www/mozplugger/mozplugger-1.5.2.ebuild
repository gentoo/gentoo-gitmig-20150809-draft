# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozplugger/mozplugger-1.5.2.ebuild,v 1.2 2004/04/08 21:27:46 centic Exp $

inherit nsplugins

DESCRIPTION="Streaming media plugin for Mozilla, based on netscape-plugger"
SRC_URI="http://downloads.mozdev.org/mozplugger/${P}.tar.gz"
HOMEPAGE="http://mozplugger.mozdev.org/"

KEYWORDS="~x86 -ppc ~sparc"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND="virtual/glibc"
# TODO what about Opera or Galeon?
RDEPEND="${DEPEND}
	!virtual/plugger
	net-www/mozilla*"
PROVIDE="virtual/plugger"

src_compile()
{
	cd ${S}
	make linux || die
}

src_install()
{
	cd ${S}

	PLUGIN=/usr/lib/$PLUGINS_DIR
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
