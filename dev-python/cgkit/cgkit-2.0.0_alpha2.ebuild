# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cgkit/cgkit-2.0.0_alpha2.ebuild,v 1.1 2005/03/10 11:11:57 chrb Exp $

inherit distutils

MY_P=${P/_/}
DESCRIPTION="Python library for creating 3D images"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://cgkit.sourceforge.net"
DEPEND="dev-lang/python
	dev-python/pyrex
	dev-util/scons
	dev-libs/boost"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
S=${WORKDIR}/${MY_P}

src_compile() {
	cd ${S}/supportlib
	scons
}
