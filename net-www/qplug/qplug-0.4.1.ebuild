# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/qplug/qplug-0.4.1.ebuild,v 1.3 2004/10/01 23:46:35 pyrania Exp $

inherit nsplugins

DESCRIPTION="Netscape plugin which gets basic informations from a QuakeWorld or Quake2 server"
HOMEPAGE="http://www.linuxquake.com/qplug/"
SRC_URI="http://www.linuxquake.com/qplug/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	emake OPTIMIZER="${CFLAGS}" || die
}

src_install() {
	exeinto /opt/netscape/plugins
	doexe qplug.so
	inst_plugin /opt/netscape/plugins/qplug.so
	dodoc Readme
}
