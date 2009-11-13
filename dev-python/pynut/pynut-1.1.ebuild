# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pynut/pynut-1.1.ebuild,v 1.1 2009/11/13 20:12:18 ssuominen Exp $

inherit multilib python

DESCRIPTION="An abstraction class written in Python to access NUT (Network UPS Tools) server"
HOMEPAGE="http://www.lestat.st/informatique/projets/pynut-en/"
SRC_URI="http://www.lestat.st/_media/informatique/projets/pynut/python-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/python-${P}

src_install() {
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	doins PyNUT.py
	dodoc README
}

pkg_postinst() {
	python_version
	python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/PyNUT.py
}

pkg_postrm() {
	python_mod_cleanup
}
