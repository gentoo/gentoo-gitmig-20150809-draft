# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twill/twill-0.9_beta1.ebuild,v 1.3 2008/01/23 15:58:26 beandog Exp $

inherit distutils

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Simple scripting language for web browsing with Python API."
HOMEPAGE="http://twill.idyll.org/"
SRC_URI="http://darcs.idyll.org/~t/projects/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install
	if use doc; then
		dodir /usr/share/doc/${PF}/examples
		cp -R doc/* ${D}/usr/share/doc/${PF}/
		cp examples/* ${D}/usr/share/doc/${PF}/examples/
	fi
}

src_test() {
	elog "Testing disabled due to sandbox prolems opening"
	elog "a port on a server. Unpack the ebuild and run the"
	elog "tests manually with 'nosetests' (dev-python/nose)"
	elog "in the unpacked directory."
}
