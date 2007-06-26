# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-3.5.ebuild,v 1.2 2007/06/26 02:25:40 mr_bones_ Exp $

NEED_PYTHON=2.2.2

inherit distutils

IUSE=""
DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://auriga.wearlab.de/~alb/msnlib"
SRC_URI="http://auriga.wearlab.de/~alb/msnlib/files/${PV}/${P}.tar.bz2"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

src_install() {
	distutils_src_install

	dodoc doc/*

	dobin msn
	dobin msnsetup
	dobin utils/msntk

	insinto /usr/share/doc/${PF}
	doins msnrc.sample
}
