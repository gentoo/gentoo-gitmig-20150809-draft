# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyserial/pyserial-1.18.ebuild,v 1.7 2005/02/20 09:56:24 radek Exp $

inherit distutils

DESCRIPTION="Python Serial Port Extension"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
HOMEPAGE="http://pyserial.sourceforge.net"
IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86"

DEPEND="virtual/python
	app-arch/unzip"
