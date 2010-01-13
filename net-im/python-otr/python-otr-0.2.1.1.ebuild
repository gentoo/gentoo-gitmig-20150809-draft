# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/python-otr/python-otr-0.2.1.1.ebuild,v 1.1 2010/01/13 18:03:59 hanno Exp $

inherit distutils python eutils

DESCRIPTION="Python bindings for OTR encryption"
HOMEPAGE="http://pyotr.pentabarf.de/"
SRC_URI="http://pyotr.pentabarf.de/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-libs/libotr"
