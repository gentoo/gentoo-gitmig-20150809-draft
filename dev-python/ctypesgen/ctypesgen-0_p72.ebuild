# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ctypesgen/ctypesgen-0_p72.ebuild,v 1.7 2009/04/02 12:00:10 fmccor Exp $

inherit distutils

DESCRIPTION="Python wrapper generator for ctypes"
HOMEPAGE="http://code.google.com/p/ctypesgen/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/python-2.5"
