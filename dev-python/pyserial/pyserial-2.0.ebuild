# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyserial/pyserial-2.0.ebuild,v 1.8 2004/06/25 01:43:20 agriffis Exp $

inherit distutils

DESCRIPTION="Python Serial Port Extension"
HOMEPAGE="http://pyserial.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86 amd64 ~ppc alpha"

PYTHON_MODNAME="serial"
DEPEND="app-arch/unzip"
