# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/telepathy-python/telepathy-python-0.13.13.ebuild,v 1.1 2007/07/07 12:16:59 peper Exp $

inherit distutils

DESCRIPTION="Telepathy Python package containing base classes for use in connection managers, and proxy classes for use in clients."
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/dbus-python-0.71"

