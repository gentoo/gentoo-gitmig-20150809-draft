# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyserial/pyserial-2.1.ebuild,v 1.1 2005/02/20 09:56:24 radek Exp $

inherit distutils

DESCRIPTION="Python Serial Port Extension"
HOMEPAGE="http://pyserial.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"

PYTHON_MODNAME="serial"
DEPEND="app-arch/unzip"
