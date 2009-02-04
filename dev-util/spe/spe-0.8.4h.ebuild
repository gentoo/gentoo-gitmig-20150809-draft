# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/spe/spe-0.8.4h.ebuild,v 1.1 2009/02/04 16:04:45 patrick Exp $

inherit eutils python

MY_PV="0.8.4.h"

DESCRIPTION="Python IDE with Blender support"
HOMEPAGE="http://pythonide.stani.be/"
SRC_URI="mirror://berlios/python/spe-${MY_PV}-wx2.6.1.0.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc"
DEPEND=">=dev-lang/python-2.5"
RDEPEND="${DEPEND}
	 =dev-python/wxpython-2.6*
	 >=dev-python/pychecker-0.8.18
	 >=dev-util/wxglade-0.3.2"

S="${WORKDIR}/spe-${MY_PV}/"

src_compile() {
	python setup.py build || die "build failed"
}

src_install() {
	python_version
	local mypyconf
	local site_pkgs=/usr/$(get_libdir)/python${PYVER}/site-packages
	dodir ${site_pkgs}

	python setup.py install --prefix=/usr --root="${D}" || die

	doicon "${S}/build/lib/_spe/images/spe.png"
	insinto /usr/share/applications
	doins "${S}/spe.desktop"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/
}
