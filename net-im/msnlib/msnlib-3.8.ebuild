# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-3.8.ebuild,v 1.1 2012/02/15 11:58:14 djc Exp $

EAPI="2"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"
SUPPORT_PYTHON_ABIS="1"

inherit multilib distutils

DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://auriga.wearlab.de/~alb/msnlib/"
SRC_URI="http://auriga.wearlab.de/~alb/msnlib/files/${PV}/${P}.tar.bz2"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="tk"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="msncb.py msnlib.py"

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs 2 msn utils/msntk
}

src_install() {
	distutils_src_install

	dodoc doc/* || die "dodoc failed"
	dobin msn
	dobin msnsetup
	use tk && dobin utils/msntk

	insinto /usr/share/doc/${PF}
	doins msnrc.sample
}
