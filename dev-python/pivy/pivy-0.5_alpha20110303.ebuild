# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pivy/pivy-0.5_alpha20110303.ebuild,v 1.3 2011/11/27 15:32:09 dilfridge Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Coin3d binding for Python"
HOMEPAGE="http://pivy.coin3d.org/"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/coin
	>=media-libs/SoQt-1.4.2_alpha
"
DEPEND="${RDEPEND}
	|| ( =dev-lang/swig-1.3* >=dev-lang/swig-2.0.4-r1 )
"
