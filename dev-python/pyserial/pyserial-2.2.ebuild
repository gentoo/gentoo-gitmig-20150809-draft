# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyserial/pyserial-2.2.ebuild,v 1.1 2005/11/22 22:34:34 chrb Exp $

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
