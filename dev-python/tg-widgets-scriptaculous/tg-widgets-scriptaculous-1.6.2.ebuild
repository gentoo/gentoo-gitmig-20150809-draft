# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tg-widgets-scriptaculous/tg-widgets-scriptaculous-1.6.2.ebuild,v 1.2 2010/07/09 23:10:20 arfrever Exp $

PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="TurboGears widget wrapper for the Scriptaculous JavaScript library"
HOMEPAGE="http://www.turbogears.org/widgets/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-python/turbogears"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="scriptaculous"
