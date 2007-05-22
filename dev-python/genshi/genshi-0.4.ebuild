# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/genshi/genshi-0.4.ebuild,v 1.2 2007/05/22 16:20:02 pythonhead Exp $

NEED_PYTHON=2.3

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=Genshi
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python toolkit for stream-based generation of output for the web"
HOMEPAGE="http://genshi.edgewall.org/"
SRC_URI="ftp://ftp.edgewall.com/pub/genshi/${MY_P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
IUSE="examples"
DEPEND=""
RDEPEND=">=dev-python/setuptools-0.6_rc3"
S=${WORKDIR}/${MY_P}
DOCS="INSTALL.txt UPGRADE.txt"

src_install() {
	distutils_src_install

	dohtml -r doc/*
	dodoc doc/*.txt
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	PYTHONPATH=. "${python}" setup.py test || die "test failed"
}

pkg_postinst() {
	elog "If you're upgrading from 0.3.n to 0.4.n you may want to read:"
	elog "/usr/share/doc/${PF}/UPGRADE.txt.bz2"
}

