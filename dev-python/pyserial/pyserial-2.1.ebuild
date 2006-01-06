# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyserial/pyserial-2.1.ebuild,v 1.3 2006/01/06 05:50:35 vapier Exp $

inherit distutils

DESCRIPTION="Python Serial Port Extension"
HOMEPAGE="http://pyserial.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sh ~sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip"

PYTHON_MODNAME="serial"
