# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/a8/a8-0.8.ebuild,v 1.1 2012/01/11 23:52:36 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="An ultra-lightweight IDE, that embeds Vim, a terminal emulator, and a file browser"
HOMEPAGE="http://code.google.com/p/abominade/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-python/argparse
	dev-python/dbus-python
	dev-python/logbook
	dev-python/psutil
	dev-python/pyyaml
	>=dev-python/pygtk-2
	>=dev-python/pygtkhelpers-0.4.3
	x11-libs/vte:0[python]"
RDEPEND="${COMMON_DEPEND}
	app-editors/gvim"
DEPEND="${COMMON_DEPEND}"
