# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmldonkey/wmmldonkey-0.003.ebuild,v 1.4 2006/02/03 13:47:38 nelchael Exp $

DESCRIPTION="wmmsg is a dockapp to show the up and downloadrate from your mldonkey"
HOMEPAGE="http://dockapps.org/file.php/id/174"
SRC_URI="http://dockapps.org/download.php/id/298/wmmldonkey3.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
S=${WORKDIR}/wmmldonkey3

RDEPEND="|| ( (
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	net-p2p/mldonkey"

src_install()
{
	dodoc CHANGELOG LICENSE README
	exeinto /usr/bin
	doexe wmmldonkey
}

pkg_postinst()
{
	einfo "Make sure the mldonkey daemon is running before you"
	einfo "attempt to run emmldonkey..."
}
