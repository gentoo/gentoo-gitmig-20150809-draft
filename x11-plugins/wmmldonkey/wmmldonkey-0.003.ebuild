# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmldonkey/wmmldonkey-0.003.ebuild,v 1.1 2003/12/25 23:55:49 pyrania Exp $

DESCRIPTION="wmmsg is a dockapp to show the up and downloadrate from your mldonkey"
HOMEPAGE="http://dockapps.org/file.php/id/174"
SRC_URI="http://dockapps.org/download.php/id/298/wmmldonkey3.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/x11
	net-p2p/mldonkey"
S=${WORKDIR}/wmmldonkey3

src_install() {
	dodoc CHANGELOG LICENSE README
	exeinto /usr/bin
	doexe wmmldonkey
}
