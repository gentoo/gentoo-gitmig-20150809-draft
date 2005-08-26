# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyserial/pyserial-2.1.ebuild,v 1.2 2005/08/26 03:39:05 agriffis Exp $

inherit distutils

DESCRIPTION="Python Serial Port Extension"
HOMEPAGE="http://pyserial.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

PYTHON_MODNAME="serial"
DEPEND="app-arch/unzip"
