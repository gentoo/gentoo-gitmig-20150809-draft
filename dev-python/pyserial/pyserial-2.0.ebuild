# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyserial/pyserial-2.0.ebuild,v 1.4 2004/03/06 09:38:01 dholm Exp $

inherit distutils

DESCRIPTION="Python Serial Port Extension"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
HOMEPAGE="http://pyserial.sourceforge.net"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86 amd64 ~ppc"

PYTHON_MODNAME="serial"
