# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymsn/pymsn-0.2.2.ebuild,v 1.1 2007/06/10 18:34:48 peper Exp $

inherit distutils

DESCRIPTION="The library behind the msn connection manager: telepathy-butterfly"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Pymsn"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pygtk"

DOCS="AUTHORS ChangeLog NEWS README"
